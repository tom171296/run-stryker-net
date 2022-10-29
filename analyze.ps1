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
