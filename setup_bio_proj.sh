#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-bio-proj}"
echo "Creating project at ./${ROOT}"

mkdir -p "${ROOT}"/{pipeline/{nextflow,wrappers,envs,tests},pilots/{tools,data,notebooks,scratch,envs,reports},analyses/{subproj-a,subproj-b}/{notebooks,scripts,config,results,reports},shared/{pylib,rlib},.github/workflows}

# ---------------- Top-level ----------------
cat > "${ROOT}/README.md" <<'__TOP_README__'
# bio-proj

Unified bioinformatics/compbio project with shared pipelines and multiple downstream analyses.

## Structure

| Folder | Purpose |
|--------|----------|
| `pipeline/` | Shared production pipeline and wrappers |
| `pilots/` | Sandbox for testing tools before pipeline integration |
| `analyses/` | Distinct downstream analyses (subprojects) |
| `shared/` | Shared helper libraries (R/Python) |
| `.github/` | CI workflows |
__TOP_README__

cat > "${ROOT}/.gitignore" <<'__GITIGNORE__'
# data / results
results/
scratch/
*.log
*.tmp
*.bak
*.DS_Store

# Python / R
__pycache__/
.Rhistory
.Rproj.user/

# Environments
.env
.venv/
*.lock

# Ignore large data
pilots/scratch/
analyses/**/results/
__GITIGNORE__

# ---------------- Pipeline ----------------
cat > "${ROOT}/pipeline/README.md" <<'__PIPELINE_README__'
# Pipeline

Contains the shared upstream processing pipeline (Nextflow/Snakemake + wrappers).

- nextflow/: main.nf, modules/, configs
- wrappers/: Python/R helper scripts
- envs/: shared micromamba YAMLs
- tests/: small regression or smoke tests
__PIPELINE_README__

cat > "${ROOT}/pipeline/envs/base.yml" <<'__PIPELINE_ENV__'
name: bio-pipeline
channels:
  - bioconda
  - conda-forge
dependencies:
  - python=3.11
  - nextflow
  - samtools
  - bcftools
  - pigz
  - pandas
  - numpy
  - r-base
__PIPELINE_ENV__

# ---------------- Pilots ----------------
cat > "${ROOT}/pilots/README.md" <<'__PILOTS_README__'
# Pilots

Experimental sandbox for testing tools and prototypes before integration into the main pipeline.

| Folder | Purpose |
|--------|----------|
| tools/ | One-off tests for individual tools |
| data/ | Tiny toy datasets for testing |
| notebooks/ | Exploratory Jupyter/R notebooks |
| scratch/ | Temporary outputs (gitignored) |
| envs/ | Tool-specific micromamba YAMLs |
| reports/ | Summaries and results from pilot runs |
__PILOTS_README__

cat > "${ROOT}/pilots/envs/dorado_test.yml" <<'__DORADO_ENV__'
name: dorado-test
channels:
  - bioconda
  - conda-forge
dependencies:
  - dorado=1.2.0
  - samtools
  - pigz
__DORADO_ENV__

cat > "${ROOT}/pilots/envs/fgbio_test.yml" <<'__FGBIO_ENV__'
name: fgbio-test
channels:
  - bioconda
  - conda-forge
dependencies:
  - fgbio
  - samtools
  - openjdk
__FGBIO_ENV__

cat > "${ROOT}/pilots/tools/README.md" <<'__PILOT_TOOLS_README__'
# Pilot Tools

Each subfolder here tests an individual tool or pipeline segment.

Example structure:
    pilots/tools/longread_umi_test/
      run_test.sh
      example_config.yaml
__PILOT_TOOLS_README__

cat > "${ROOT}/pilots/reports/README.md" <<'__PILOT_REPORTS_README__'
# Pilot Reports

Short summaries of pilot tool tests, benchmarks, and conclusions.
__PILOT_REPORTS_README__

# ---------------- Analyses ----------------
cat > "${ROOT}/analyses/README.md" <<'__ANALYSES_README__'
# Analyses

Each subproject below contains its own downstream analysis pipeline,
using the shared upstream code from ../pipeline/.
__ANALYSES_README__

for sp in subproj-a subproj-b; do
  cat > "${ROOT}/analyses/${sp}/README.md" <<__SP_README__
# ${sp}

Downstream analysis module.

- notebooks/
- scripts/
- config/
- results/ (gitignored)
- reports/

Uses upstream pipeline from ../pipeline.
__SP_README__
done

# ---------------- Shared libs ----------------
cat > "${ROOT}/shared/README.md" <<'__SHARED_README__'
# Shared Libraries

Common helper code for all analyses.

- pylib/: Python modules installable with `pip install -e .`
- rlib/: small R packages or helper scripts
__SHARED_README__

# ---------------- GitHub CI ----------------
cat > "${ROOT}/.github/workflows/ci.yml" <<'__CI_YML__'
name: CI
on:
  push:
    branches: [ main ]
    paths-ignore:
      - 'pilots/**'
  pull_request:
    paths-ignore:
      - 'pilots/**'

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Verify structure
        run: |
          echo "Repo structure looks good."
__CI_YML__

echo "Done. Next:"
echo "  cd ${ROOT}"
echo "  git init && git add . && git commit -m 'Initial scaffold'"
