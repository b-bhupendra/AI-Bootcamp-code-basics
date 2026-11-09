<#
.SYNOPSIS
    Fetches and updates all Git submodules to their latest remote versions.
#>

Write-Host "Updating all Git submodules to their latest remote commits..." -ForegroundColor Cyan
git submodule update --remote --merge
if ($LASTEXITCODE -eq 0) {
    Write-Host "All submodules successfully updated!" -ForegroundColor Green
} else {
    Write-Error "Failed to update submodules."
}
