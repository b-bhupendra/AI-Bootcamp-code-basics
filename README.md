# AI Bootcamp - Code Basics & Projects Hub

Welcome to the **AI Bootcamp** master repository. This repository acts as an organized hub containing all individual projects, code exercises, and modules developed during the bootcamp.

Each project inside this repository is an **independent Git submodule** linked to its own GitHub repository.

---

## 🎯 Architecture & How Submodules Work

```
AI-Bootcamp-code-basics (Parent Repository)
│
├── .gitmodules                     # Tracks sub-repository URLs and paths
├── README.md                       # Master index & guide
├── add-project.ps1                 # Automated script to add new project submodules
├── sync-submodules.ps1             # Pulls latest updates for all submodules
│
└── projects/
    └── starter-project/   ───────> [github.com/b-bhupendra/ai-bootcamp-starter-project]
    └── <future-projects>/ ───────> [Independent GitHub Repositories]
```

### Key Advantages:
* **True Independence:** Working and pushing inside `projects/starter-project/` **only** affects that repository. It does not touch other projects or require changes to this main repo.
* **Separation of Concerns:** Each project maintains its own Git commit history, issue tracker, pull requests, releases, and deployment hooks.
* **Portfolio Organization:** Anyone viewing this main repository can easily browse all bootcamp projects from one central index.

---

## 🚀 Quick Start Guide

### 1. Cloning this Hub (with all submodules)
When cloning for the first time, use `--recurse-submodules` so Git downloads all child repositories:
```bash
git clone --recurse-submodules https://github.com/b-bhupendra/AI-Bootcamp-code-basics.git
```

If you already cloned without `--recurse-submodules`, initialize and fetch them:
```bash
git submodule update --init --recursive
```

---

## 🛠️ Adding a New Project Submodule

### Option A: Using the Automated PowerShell Script
Run the helper script from the root of this repo:
```powershell
# Create a new GitHub repo and link it automatically:
.\add-project.ps1 -RepoName "ai-project-02-rag" -Description "RAG system with LangChain"

# Or link an already existing GitHub repository:
.\add-project.ps1 -ExistingUrl "https://github.com/b-bhupendra/my-existing-project.git" -PathName "ai-project-03"
```

### Option B: Manual Git Commands
1. Create the repository on GitHub (e.g., `https://github.com/b-bhupendra/my-new-project.git`).
2. Run in the root of `AI-Bootcamp-code-basics`:
   ```bash
   git submodule add https://github.com/b-bhupendra/my-new-project.git projects/my-new-project
   git commit -m "Add my-new-project submodule"
   git push origin main
   ```

---

## 💻 Working Inside a Project Sub-Repository

When developing inside a specific project, navigate into its folder:

```bash
cd projects/starter-project

# Check status (you are inside the child git repo!)
git status

# Make your changes, commit, and push directly:
git add .
git commit -m "Update model architecture"
git push origin main
```
> [!NOTE]
> This push goes directly to `b-bhupendra/ai-bootcamp-starter-project`. It does **not** push to or alter other projects.

---

## 🔄 Keeping Submodules Updated

To pull the latest changes for all submodules at once:
```powershell
.\sync-submodules.ps1
```
Or with standard Git:
```bash
git submodule update --remote --merge
```

---

## 📂 Project Directory

| Project Name | Path | Repository Link | Description |
| :--- | :--- | :--- | :--- |
| **Starter Project** | `projects/starter-project` | [ai-bootcamp-starter-project](https://github.com/b-bhupendra/ai-bootcamp-starter-project) | Starter template and hello-world AI test pipeline |

*(Add new projects to this table as your bootcamp progresses!)*
