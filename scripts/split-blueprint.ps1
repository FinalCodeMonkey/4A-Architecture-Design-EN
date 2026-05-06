<#
.SYNOPSIS
    Split a raw chat output or merged blueprint file into chapter-based temporary files.

.DESCRIPTION
    For fallback scenarios without file-write tool support:
    After the user pastes multi-turn AI output into a single Markdown file,
    this script splits it by chapter headings into five temporary files,
    which can then be merged by merge-blueprint.ps1.

    Recognized chapter heading keywords (line must start with ## ):
      "BA Layer Table", "DA Layer Table", "AA Layer Table", "Mapping Matrix",
      "Alignment Verification Table"

.PARAMETER InputFile
    Source file containing all chapter content (required).

.PARAMETER Dir
    Output directory for temporary files. Defaults to the same directory as InputFile.

.PARAMETER Scene
    Scene name, only used when -Merge is specified (default: blueprint).

.PARAMETER Merge
    After splitting, immediately invoke merge-blueprint.ps1 to merge.

.EXAMPLE
    .\scripts\split-blueprint.ps1 -InputFile _raw_output.md

.EXAMPLE
    .\scripts\split-blueprint.ps1 -InputFile _raw_output.md -Merge -Scene {scene-name}

.EXAMPLE
    .\scripts\split-blueprint.ps1 -InputFile _raw_output.md -Dir "{target-dir}" -Merge -Scene {scene-name}
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $InputFile,

    [string] $Dir   = "",
    [string] $Scene = "blueprint",
    [switch] $Merge
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# -- 1. Resolve paths --------------------------------------------------------------
$inputPath = Resolve-Path $InputFile | Select-Object -ExpandProperty Path

if ($Dir -eq "") {
    $dir = Split-Path $inputPath -Parent
} else {
    $dir = Resolve-Path $Dir | Select-Object -ExpandProperty Path
}

# -- 2. Chapter definitions (keyword matching on ## headings, tolerant of numbering)
$sections = @(
    [PSCustomObject]@{ Keyword = "BA Layer Table";                    File = "_tmp_ba.md"     }
    [PSCustomObject]@{ Keyword = "DA Layer Table";                    File = "_tmp_da.md"     }
    [PSCustomObject]@{ Keyword = "AA Layer Table";                    File = "_tmp_aa.md"     }
    [PSCustomObject]@{ Keyword = "Mapping Matrix";                    File = "_tmp_matrix.md" }
    [PSCustomObject]@{ Keyword = "Alignment Verification Table";      File = "_tmp_verify.md" }
)

# -- 3. Read source file -----------------------------------------------------------
$lines = Get-Content $inputPath -Encoding UTF8

# -- 4. Locate chapter start lines (0-based index) --------------------------------
$starts = @{}   # File -> lineIndex

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if (-not $line.StartsWith("##")) { continue }

    foreach ($s in $sections) {
        if ($starts.ContainsKey($s.File)) { continue }
        if ($line -match [regex]::Escape($s.Keyword)) {
            $starts[$s.File] = $i
        }
    }
}

if ($starts.Count -eq 0) {
    Write-Error "No recognized chapter headings found in file (## BA Layer Table / ## DA Layer Table etc.). Please verify input file format."
    exit 1
}

# -- 5. Extract chapter content and write temp files --------------------------------
for ($si = 0; $si -lt $sections.Count; $si++) {
    $s = $sections[$si]

    if (-not $starts.ContainsKey($s.File)) {
        Write-Warning "Chapter not found: '$($s.Keyword)', skipped"
        continue
    }

    $startLine = $starts[$s.File] + 1      # Skip the heading line itself

    # End line: line before next valid chapter, or end of file
    $endLine = $lines.Count - 1
    for ($sj = $si + 1; $sj -lt $sections.Count; $sj++) {
        $nextFile = $sections[$sj].File
        if ($starts.ContainsKey($nextFile) -and $starts[$nextFile] -gt $starts[$s.File]) {
            $endLine = $starts[$nextFile] - 1
            break
        }
    }

    # Extract content: remove --- separators
    [string[]]$chunk = $lines[$startLine..$endLine] | Where-Object { $_ -ne "---" }

    # Trim leading empty lines
    while ($chunk.Count -gt 0 -and $chunk[0].Trim() -eq "") {
        $chunk = $chunk[1..($chunk.Count - 1)]
    }
    # Trim trailing empty lines
    while ($chunk.Count -gt 0 -and $chunk[-1].Trim() -eq "") {
        $chunk = $chunk[0..($chunk.Count - 2)]
    }

    if ($chunk.Count -eq 0) {
        Write-Warning "Chapter content is empty: '$($s.Keyword)', skipped"
        continue
    }

    $outPath = Join-Path $dir $s.File
    $chunk | Set-Content $outPath -Encoding UTF8
    Write-Host "  [OK] Extracted: $($s.File) ($($chunk.Count) lines)" -ForegroundColor Green
}

Write-Host ""
Write-Host "[OK] Split complete. Temporary files written to: $dir" -ForegroundColor Cyan

# -- 6. Optional: merge immediately after split ------------------------------------
if ($Merge) {
    Write-Host ""
    Write-Host "Executing merge..." -ForegroundColor Cyan
    $mergeScript = Join-Path $PSScriptRoot "merge-blueprint.ps1"
    & $mergeScript -Dir $dir -Scene $Scene
}
