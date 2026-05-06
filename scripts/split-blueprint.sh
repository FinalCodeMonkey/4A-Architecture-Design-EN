#!/usr/bin/env bash
# split-blueprint.sh — Split a raw chat output or merged blueprint file into chapter-based temporary files
#
# For fallback scenarios without file-write tool support:
# After the user pastes multi-turn AI output into a single Markdown file,
# this script splits it by chapter headings into five temporary files,
# which can then be merged by merge-blueprint.sh.
#
# Recognized chapter heading keywords (line must start with ## ):
#   "BA Layer Table", "DA Layer Table", "AA Layer Table", "Mapping Matrix",
#   "Alignment Verification Table"
#
# Usage:
#   bash split-blueprint.sh -i INPUTFILE [-d DIR] [-s SCENE] [-m]
#
# Options:
#   -i INPUTFILE  Source file (required)
#   -d DIR        Output directory for temporary files (default: same as INPUTFILE)
#   -s SCENE      Scene name, only used with -m (default: blueprint)
#   -m            After splitting, automatically invoke merge-blueprint.sh
#
# Examples:
#   bash split-blueprint.sh -i _raw_output.md
#   bash split-blueprint.sh -i _raw_output.md -m -s {scene-name}
#   bash split-blueprint.sh -i _raw_output.md -d {target-dir} -m -s {scene-name}

set -euo pipefail

# -- Parse arguments ---------------------------------------------------------------
INPUT=""
DIR=""
SCENE="blueprint"
DO_MERGE=false

while getopts "i:d:s:m" opt; do
  case $opt in
    i) INPUT="$OPTARG" ;;
    d) DIR="$OPTARG" ;;
    s) SCENE="$OPTARG" ;;
    m) DO_MERGE=true ;;
    *) echo "Usage: $0 -i INPUTFILE [-d DIR] [-s SCENE] [-m]" >&2; exit 1 ;;
  esac
done

if [[ -z "$INPUT" ]]; then
  echo "Error: Input file must be specified via -i" >&2
  exit 1
fi

# -- Resolve paths -----------------------------------------------------------------
INPUT="$(cd "$(dirname "$INPUT")" && pwd)/$(basename "$INPUT")"

if [[ -z "$DIR" ]]; then
  DIR="$(dirname "$INPUT")"
else
  DIR="$(cd "$DIR" && pwd)"
fi

# -- Chapter definitions (keyword -> output file, fixed order) ---------------------
KEYWORDS=("BA Layer Table" "DA Layer Table" "AA Layer Table" "Mapping Matrix" "Alignment Verification Table")
OUTFILES=("_tmp_ba.md" "_tmp_da.md" "_tmp_aa.md" "_tmp_matrix.md" "_tmp_verify.md")

total_lines=$(wc -l < "$INPUT")

# -- Locate chapter start line numbers (grep -n for ## headings) -------------------
declare -a STARTS=()
for kw in "${KEYWORDS[@]}"; do
  lineno=$(grep -n "^##.*${kw}" "$INPUT" | head -1 | cut -d: -f1 || true)
  STARTS+=("${lineno:-}")
done

# Check at least one chapter found
found=0
for s in "${STARTS[@]}"; do [[ -n "$s" ]] && ((found++)) || true; done

if [[ $found -eq 0 ]]; then
  echo "Error: No recognized chapter headings found in file. Please verify input file format." >&2
  exit 1
fi

# -- Extract chapter content and write temp files ----------------------------------
trim_empty_lines() {
  echo "$1" | awk '
    /[^[:space:]]/ { found=1 }
    found { lines[NR]=$0 }
    END {
      last=0
      for (i=NR; i>=1; i--) { if (lines[i] ~ /[^[:space:]]/) { last=i; break } }
      for (i=1; i<=last; i++) print lines[i]
    }
  '
}

for i in "${!KEYWORDS[@]}"; do
  start="${STARTS[$i]}"

  if [[ -z "$start" ]]; then
    echo "Warning: Chapter not found: '${KEYWORDS[$i]}', skipped" >&2
    continue
  fi

  # End line: line before next valid chapter, or end of file
  end=$total_lines
  for j in $(seq $((i + 1)) $((${#KEYWORDS[@]} - 1))); do
    ns="${STARTS[$j]}"
    if [[ -n "$ns" && "$ns" -gt "$start" ]]; then
      end=$((ns - 1))
      break
    fi
  done

  # Extract: from line after chapter heading to end line, remove --- separators, trim
  chunk=$(sed -n "$((start + 1)),${end}p" "$INPUT" | grep -v "^---$" || true)
  chunk=$(trim_empty_lines "$chunk")

  if [[ -z "$chunk" ]]; then
    echo "Warning: Chapter content is empty: '${KEYWORDS[$i]}', skipped" >&2
    continue
  fi

  outpath="$DIR/${OUTFILES[$i]}"
  printf '%s\n' "$chunk" > "$outpath"
  line_count=$(wc -l < "$outpath")
  echo "  ✓ Extracted: ${OUTFILES[$i]} (${line_count} lines)"
done

echo ""
echo "✓ Split complete. Temporary files written to: $DIR"

# -- Optional: merge immediately after split ---------------------------------------
if [[ "$DO_MERGE" == true ]]; then
  echo ""
  echo "Executing merge..."
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  bash "$script_dir/merge-blueprint.sh" -d "$DIR" -s "$SCENE"
fi
