#!/bin/bash

# ── Project Scaffolding Utility ───────────────────────────
# Creates a new Python project with standard structure,
# config files and dependencies based on project type.

echo ""
echo "🏗️  Python Project Scaffolding Utility"
echo "======================================="
echo ""

# ── Collect Inputs ────────────────────────────────────────
read -p "Enter the project name: " project_name
read -p "Enter the project location (absolute path): " project_location
read -p "Enter the project description: " project_description

echo ""
echo "🔧 Select project type:"
echo "   1) General Python"
echo "   2) LangGraph / LangChain"
echo "   3) Data Analysis / Pandas"
echo ""
read -p "Enter the number corresponding to the project type (1/2/3): " project_type
echo ""
echo "🔑 Select API keys needed:"
echo "   1) OpenAI only"
echo "   2) Anthropic only"
echo "   3) Both"
echo "   4) None"
echo ""
read -p "Enter choice (1/2/3/4): " api_keys

# ── Validate Inputs ───────────────────────────────────────
if [[ -z "$project_name" ]]; then
    echo "❌ Project name is required. Exiting."
    exit 1
fi

if [[ -z "$project_location" ]]; then
    echo "❌ Project location is required. Exiting."
    exit 1
fi

if [[ -z "$project_description" ]]; then
    echo "❌ Project description is required. Exiting."
    exit 1
fi

if [[ ! "$project_type" =~ ^[1-3]$ ]]; then
    echo "❌ Invalid project type. Please enter 1, 2, or 3. Exiting."
    exit 1
fi

if [[ ! "$api_keys" =~ ^[1-4]$ ]]; then
    echo "❌ Invalid API keys selection. Please enter 1, 2, 3, or 4. Exiting."
    exit 1
fi
echo "✅ Inputs validated"

# ── Create Directory Structure ────────────────────────────
# Expand ~ to full home directory path
project_location="${project_location/#\~/$HOME}"
project_path="$project_location/$project_name"

echo ""
echo "📁 Creating project structure at: $project_path"

# Check if directory already exists
if [[ -d "$project_path" ]]; then
    echo "❌ Directory '$project_path' already exists. Please choose a different project name or location. Exiting."
    exit 1
fi
mkdir -p "$project_path/src"
mkdir -p "$project_path/outcomes"

echo "✅ Directory structure created"   
echo "  $project_path/"
echo "  $project_path/src/"
echo "  $project_path/outcomes/"

# ── Create .gitignore ─────────────────────────────────────
echo ""

cat > "$project_path/.gitignore" << EOF

# Virtual Environment
venv/
.venv*/

# Python cache files
__pycache__/
*.pyc
*.pyo
*.pyd

# Environment variables
.env

# Logs
*.log

# SQLite database files
*.db
*.db-shm
*.db-wal

# Mac System files
.DS_Store

# Output files
output/
outcomes/

# Node
node_modules/
EOF
echo "✅ .gitignore created"


# - Create .env and .env.example based on API key selection
echo ""
echo "📝 Creating .env and .env.example based on API key selection..."

# Build .env and .env.example content based on API key selection
case $api_keys in
    1)
        env_content="OPENAI_API_KEY=your-openai-api-key-here"
        ;;
    2)
        env_content="ANTHROPIC_API_KEY=your-anthropic-api-key-here"
        ;;
    3)
        env_content="OPENAI_API_KEY=your-openai-api-key-here
ANTHROPIC_API_KEY=your-anthropic-api-key-here"
        ;;
    4)
        env_content="# No API keys needed for this project"
        ;;
esac

# create .env.example
cat > "$project_path/.env.example" << EOF
# Copy this file to .env and fill in your values
$env_content
EOF
echo "✅ .env.example created"

# Create .env with same structure
cat > "$project_path/.env" << EOF
# Do not commit this file to git
$env_content
EOF

echo "✅ .env and .env.example created"

# ── Create requirements.txt ───────────────────────────────
echo ""
echo "📝 Creating requirements.txt..."

case $project_type in
    1)
        # General Python
        requirements="# General Python
python-dotenv"
        ;;
    2)
        # LangGraph / LangChain
        requirements="# LangGraph / LangChain
langgraph
langgraph-checkpoint-sqlite
langchain
langchain-openai
langchain-anthropic
python-dotenv"
        ;;
    3)
        # Data Analysis / Pandas
        requirements="# Data Analysis / Pandas
pandas
numpy
matplotlib
seaborn
python-dotenv"
        ;;
esac

cat > "$project_path/requirements.txt" << EOF
$requirements
EOF

echo "✅ requirements.txt created"

# ── Create README.md ──────────────────────────────────────
echo ""
echo "📝 Creating README.md..."

# Get project type label for README
case $project_type in
    1) type_label="General Python" ;;
    2) type_label="LangGraph / LangChain" ;;
    3) type_label="Data Analysis / Pandas" ;;
esac

cat > "$project_path/README.md" << EOF
# $project_name

## About
$project_name is a $type_label project.

## Project Structure
\`\`\`
$project_name/
├── src/          # Source code
├── outcomes/     # Output files
├── .env          # Environment variables (not committed)
├── .env.example  # Environment variable template
├── requirements.txt
└── README.md
\`\`\`

## Setup
1. Create and activate virtual environment:
\`\`\`bash
python3 -m venv .venv
source .venv/bin/activate
\`\`\`

2. Install dependencies:
\`\`\`bash
pip install -r requirements.txt
\`\`\`

3. Configure environment variables:
\`\`\`bash
cp .env.example .env
# Edit .env with your actual values
\`\`\`

## Usage
\`\`\`bash
python3 src/main.py
\`\`\`
EOF

echo "✅ README.md created"

# ── Final Summary ─────────────────────────────────────────
echo ""
echo "======================================="
echo "✅ Project '$project_name' scaffolded!"
echo "======================================="
echo ""
echo "📁 Location:     $project_path"
echo "🔧 Project type: $type_label"
echo ""
echo "📂 Structure created:"
echo "   $project_name/"
echo "   ├── src/"
echo "   ├── outcomes/"
echo "   ├── .env"
echo "   ├── .env.example"
echo "   ├── .gitignore"
echo "   ├── requirements.txt"
echo "   └── README.md"
echo ""
echo "🚀 Next steps:"
echo "   1) cd $project_path"
echo "   2) python3 -m venv .venv"
echo "   3) source .venv/bin/activate"
echo "   4) pip install -r requirements.txt"
echo "   5) When ready to push: ~/git_setup.sh"
echo ""