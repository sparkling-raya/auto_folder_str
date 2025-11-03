# create_structure.sh
## Usage

Run this the first thing when you want to create a project folder

`bash create_structure.sh <your-project>`

Folder structure
```
/project_name/
  ├── data/
  │   ├── raw/
  │   └── processed/
  ├── src/
  │   ├── scripts/
  │   ├── functions/
  │   ├── notebooks/
  │   └── main.py
  ├── results/
  │   ├── figures/
  │   ├── reports/
  │   └── tables/
  ├── docs/
  │   └── index.md
  ├── env/
  ├── logs/
  └── tests/
  │   └── test_main.py
  ├── LICENSE
  └── README.md
```


# setup_bio_proj.sh

A lightweight Bash script that bootstraps a complete **bioinformatics / computational biology project scaffold**.  
It creates a ready-to-use structure for shared pipelines, pilot tool testing, downstream analyses, and minimal CI.

---

## What it creates

After running the script, you'll get this structure:
```
bio-proj/
├─ pipeline/
│  ├─ nextflow/
│  ├─ wrappers/
│  ├─ envs/base.yml
│  ├─ tests/
│  └─ README.md
├─ pilots/
│  ├─ tools/
│  ├─ data/
│  ├─ notebooks/
│  ├─ scratch/
│  ├─ envs/            (e.g., dorado_test.yml, fgbio_test.yml)
│  ├─ reports/
│  └─ README.md
├─ analyses/
│  ├─ subproj-a/
│  ├─ subproj-b/
│  └─ README.md
├─ shared/
│  ├─ pylib/
│  ├─ rlib/
│  └─ README.md
├─ .github/workflows/ci.yml
├─ .gitignore
└─ README.md
```
---

## Usage

1) Run with default name:

    `bash setup_bio_proj.sh`

→ Creates a new folder named `bio-proj/`.

2) Run with a custom project name:

    `bash setup_bio_proj.sh my-cool-project`

→ Creates `my-cool-project/` instead.

---

## How it works

These lines control naming and feedback:

    ROOT="${1:-bio-proj}"        # first arg or default 'bio-proj'
    echo "Creating project at ./${ROOT}"

Then the script:
1. Creates all subdirectories.
2. Writes README files and example environment YAMLs.
3. Generates a minimal GitHub CI workflow.
4. Prints a reminder to initialize Git.

---

## Dependencies

- Bash (Linux, macOS, or WSL)
- Git (for version control after creation)
- Optional: micromamba/conda (for the example YAMLs)

**Windows tip:** Run in **WSL** or **Git Bash** to keep LF line endings for shell scripts.

---

## After setup

Initialize and push to GitHub (example):

    git init
    git add .
    git commit -m "Initial scaffold"
    git branch -M main
    git remote add origin git@github.com:USERNAME/bio-proj.git
    git push -u origin main

Start experimenting in `pilots/` (small test data in `pilots/data/`, envs in `pilots/envs/`).  
Once a pilot is stable, promote code into `pipeline/`.

---

## Customization

- Pin tool versions in `pipeline/envs/base.yml`.
- Add more `pilots/envs/*.yml` for each tool you trial.
- Extend `.github/workflows/ci.yml` with smoke tests or linting.
- Build reusable utilities in `shared/pylib` (Python) and `shared/rlib` (R).

---

## Line ending note (Windows)

If you see this warning on `git add`:

    warning: LF will be replaced by CRLF

It’s about line endings. Prefer LF for shell scripts. You can enforce LF with:

    git config core.autocrlf false
    git add --renormalize .

Or convert a file with:

    dos2unix setup_bio_proj.sh

---

## License

MIT — use freely in academic or industry projects.

