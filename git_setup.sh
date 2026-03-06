#!/bin/bash

# ---- Utility that automates setting up new GitHub repository for a project ----
echo "🚀 Git Repository Setup Utility"
echo "==============================="

# - Lets ask for Inputs
read -p "Enter the repository name: " repository_name
read -p "Enter the GitHub URL for the repository (e.g., https://github.com/username/repo.git): " github_url

# Validate the Inputs
if [[ -z "$repository_name" || -z "$github_url" ]]; then
    echo "❌ All fields are required. Please provide valid inputs."
    exit 1
fi

# Check if .gitignore file exists, if not create one
if [[ ! -f .gitignore ]]; then
    echo "Creating .gitignore file..."

cat > .gitignore << 'EOF'

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
else
    echo ".gitignore file already exists. Skipping creation."
fi

# ── Create .env.example ───────────────────────────────────
echo "📝 Creating .env.example..."
cat > .env.example << 'EOF'
# Copy this file to .env and fill in your values
OPENAI_API_KEY=your-openai-api-key-here
ANTHROPIC_API_KEY=your-anthropic-api-key-here
EOF

echo "✅ .env.example created"

# ── Git init ──────────────────────────────────────────────
echo "🔧 Initializing git repository..."
git init
git branch -M main

# ── Git add and commit ────────────────────────────────────
echo "📦 Staging files..."
git add .

echo "💾 Committing..."
git commit -m "$repository_name - Initial Commit"

# ── Git remote and push ───────────────────────────────────
echo "🔗 Adding remote origin..."
git remote add origin "$github_url"

echo "⬆️  Pushing to GitHub..."
git push -u origin main

# ── Done ──────────────────────────────────────────────────
echo ""
echo "✅ Done! Repository '$repository_name' is live at $github_url"
