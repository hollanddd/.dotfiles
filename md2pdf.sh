#!/bin/bash

# md2pdf.sh - Convert Markdown to PDF with professional formatting
# Usage: ./md2pdf.sh input.md [output.pdf]

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 input.md [output.pdf]"
    echo "  input.md   - Markdown file to convert"
    echo "  output.pdf - Optional output filename (defaults to input name with .pdf)"
    exit 1
fi

INPUT="$1"

if [ ! -f "$INPUT" ]; then
    echo "Error: File '$INPUT' not found"
    exit 1
fi

# Determine output filename
if [ -z "$2" ]; then
    OUTPUT="${INPUT%.md}.pdf"
else
    OUTPUT="$2"
fi

# Get the directory of the input file for resource path
INPUT_DIR=$(cd "$(dirname "$INPUT")" && pwd)
INPUT_BASENAME=$(basename "$INPUT")

# Create temporary LaTeX header for professional formatting
HEADER_FILE=$(mktemp /tmp/pandoc-header.XXXXXX)
mv "$HEADER_FILE" "${HEADER_FILE}.tex"
HEADER_FILE="${HEADER_FILE}.tex"
cat > "$HEADER_FILE" << 'LATEX'
% Compact sans-serif font: Helvetica
\usepackage[scaled=0.92]{helvet}
\usepackage[T1]{fontenc}
\renewcommand{\familydefault}{\sfdefault}

% Better tables
\usepackage{booktabs}
\usepackage{longtable}
\usepackage{array}
\renewcommand{\arraystretch}{1.3}

% Compact code blocks
\usepackage{inconsolata}

% Tighter spacing
\usepackage{parskip}
\setlength{\parskip}{0.5em}
LATEX

# Run pandoc with formatting options
# --resource-path allows pandoc to find images relative to input file and home directory
pandoc "$INPUT" \
    -o "$OUTPUT" \
    -V geometry:margin=0.85in \
    -V fontsize=10pt \
    -V colorlinks=true \
    -V linkcolor=blue \
    -V urlcolor=blue \
    --resource-path="$INPUT_DIR:$HOME" \
    --include-in-header="$HEADER_FILE"

# Clean up
rm -f "$HEADER_FILE"

echo "Created: $OUTPUT"
