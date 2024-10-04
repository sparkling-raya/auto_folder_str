#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
  echo "Error: Project name is required"
  echo "Usage: bash create_structure.sh project_name"
  exit 1
fi

# Create the main project directory
mkdir -p "$1"

# Navigate into the project directory
cd "$1"

# Create the folder structure
mkdir -p src/functions src/notebooks src/scripts tests docs data/raw data/processed results/figures results/tables results/reports env logs

# Create common files
touch README.md LICENSE .gitignore src/main.py tests/test_main.py docs/index.md src/notebooks/analysis.ipynb

# Success message
echo "Project structure for '$1' has been created."




