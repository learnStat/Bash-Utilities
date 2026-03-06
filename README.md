# Developer Utilities

A collection of bash utilities to streamline Python project setup and 
GitHub repository management. Built collaboratively with Claude (Anthropic) 
as a learning exercise in bash scripting.

## Utilities

### 🏗️ scaffold.sh
Scaffolds a new Python project with a standard directory structure, 
configuration files, and dependencies based on project type.

**What it creates:**
```
ProjectName/
├── src/          # Source code
├── outcomes/     # Output files
├── .env          # Environment variables (not committed)
├── .env.example  # Environment variable template
├── .gitignore    # Pre-configured for Python projects
├── requirements.txt  # Dependencies based on project type
└── README.md     # Project documentation template
```

**Supported project types:**
- General Python
- LangGraph / LangChain
- Data Analysis / Pandas

**Usage:**
```bash
~/scaffold.sh
```

---

### 🚀 git_setup.sh
Automates the initial GitHub repository setup for a new project including 
git initialization, initial commit, and pushing to GitHub.

**What it does:**
- Initializes git repository
- Creates `.gitignore` if not present
- Creates `.env.example`
- Stages and commits all files
- Adds remote origin and pushes to GitHub

**Usage:**
```bash
~/git_setup.sh
```

---

## Recommended Workflow
```
1. Create new project:     ~/scaffold.sh
2. Write your code...
3. Push to GitHub:         ~/git_setup.sh
```

## Setup

Clone this repo and copy the scripts to your home directory:
```bash
git clone https://github.com/learnStat/dev-utilities.git
cp dev-utilities/scaffold.sh ~/scaffold.sh
cp dev-utilities/git_setup.sh ~/git_setup.sh
chmod +x ~/scaffold.sh ~/git_setup.sh
```

## Attribution

These utilities were built collaboratively with 
[Claude](https://claude.ai) (Anthropic's AI assistant) 
as a hands-on learning exercise in bash scripting. 
The requirements, design decisions, iterative refinements, 
and testing were driven by the author. Claude served as 
a coding partner and bash instructor throughout the process.