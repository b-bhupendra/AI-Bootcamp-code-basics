<#
.SYNOPSIS
    Adds a new sub-repository (Git submodule) to the AI Bootcamp hub.

.DESCRIPTION
    Can create a new GitHub repo using GitHub CLI (gh) and link it, or link an existing repo.

.EXAMPLE
    .\add-project.ps1 -RepoName "project-02-rag-pipeline" -Description "RAG pipeline implementation"
    .\add-project.ps1 -ExistingUrl "https://github.com/b-bhupendra/my-repo.git" -PathName "my-repo"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$RepoName,

    [Parameter(Mandatory = $false)]
    [string]$Description = "AI Bootcamp Project",

    [Parameter(Mandatory = $false)]
    [ValidateSet("public", "private")]
    [string]$Visibility = "public",

    [Parameter(Mandatory = $false)]
    [string]$ExistingUrl,

    [Parameter(Mandatory = $false)]
    [string]$PathName
)

$ErrorActionPreference = "Stop"

if (-not $RepoName -and -not $ExistingUrl) {
    Write-Error "Please provide either -RepoName (to create a new GitHub repo) or -ExistingUrl (to link an existing repo)."
    exit 1
}

$targetUrl = ""
$targetFolder = ""

if ($ExistingUrl) {
    $targetUrl = $ExistingUrl
    if ($PathName) {
        $targetFolder = $PathName
    } else {
        $basename = [System.IO.Path]::GetFileNameWithoutExtension($ExistingUrl)
        $targetFolder = $basename
    }
} else {
    Write-Host "Creating new GitHub repository '$RepoName' ($Visibility)..." -ForegroundColor Cyan
    $output = gh repo create $RepoName "--$Visibility" --description $Description --add-readme 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to create GitHub repo: $output"
        exit $LASTEXITCODE
    }
    
    $user = (gh api user --jq '.login').Trim()
    $targetUrl = "https://github.com/$user/$RepoName.git"
    $targetFolder = if ($PathName) { $PathName } else { $RepoName }
}

$submodulePath = "projects/$targetFolder"

Write-Host "Adding submodule at '$submodulePath' from $targetUrl..." -ForegroundColor Cyan
git submodule add $targetUrl $submodulePath

if ($LASTEXITCODE -eq 0) {
    git commit -m "Add submodule: $targetFolder ($targetUrl)"
    Write-Host "Pushing main repo updates to GitHub..." -ForegroundColor Cyan
    git push origin main
    Write-Host "Successfully added submodule at '$submodulePath'!" -ForegroundColor Green
    Write-Host "You can now enter 'cd $submodulePath' to work independently in that repository." -ForegroundColor Yellow
} else {
    Write-Error "Failed to add git submodule."
}
