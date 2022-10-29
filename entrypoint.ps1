#!/usr/bin/env pwsh
param (
    [Parameter(Position=0, mandatory=$true)]
    [string]$TestProject,

    [Parameter(Position=1, mandatory=$false)]
    [int]$BreakAt=0
)

###
# Mutation test
#
Write-Host "Changing direcotry to $TestProject"
Set-Location -Path $TestProject

Write-Host "Starting Stryker.NET run"
dotnet stryker `
  --break-at $BreakAt  `
  --reporter html `
  --reporter json `
  --reporter cleartext

###
# Analyze report
#
Write-Host "Analyze mutation report"

# Set variables
$owner = $env:GITHUB_REPOSITORY_OWNER
$repo = $env:GITHUB_REPOSITORY
$pr = $env:PR_NUMBER

# Login to the github CLI.
gh auth login --with-token $env:GITHUB_TOKEN

# Get the report
$report = Get-ChildItem -Filter "$($TestProject)/StrykerOutput/**/**/*.json" | Select-Object -First 1 | ConvertFrom-Json

# Get the PR commits
Write-Host "Fetch PR #$pr commits"
$shas = gh api `
  -H "Accept: application/vnd.github+json" `
  "/repos/$owner/$repo/pulls/$pr/commits" `
  --jq "[.[0, -1].sha]" | ConvertFrom-Json

# Get the changed files
$parentCommit = git log --pretty=%P -n 1 $shas[0]
Write-Host "Determine changed files, between commits $parentCommit $($shas[1])"
$changedFiles = git diff --name-only $parentCommit $shas[1]
Write-Host "Found $($changedFiles.length) changed files"

# Comment mutations to PR
$projectPath = $report.projectRoot
$changedFiles | ForEach-Object {
    $filePath = "$($projectPath)/$($_)"
    $mutationFile = $report.files.$filePath
    if ($mutationFile -eq $null) {
        return
    }

    $mutationFile.mutants | ForEach-Object {
        Write-Host "Create PR comment for mutant with id $($_.id)"
        gh api `
            --method POST `
            -H "Accept: application/vnd.github+json" `
            "/repos/$owner/$repo/pulls/$pr/comments" `
            -f body="Mutant survived, reason: '$($_.statusReason)'" `
            -f commit_id="$($shas[1])" `
            -f path="$($changedFiles[1])" `
            -F line="$($_.location.start.line)"
    }
}
