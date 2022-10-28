# Run Stryker for .Net github action

This actions runs [Stryker for .Net](https://stryker-mutator.io/docs/stryker-net/introduction/) on your specified test project.

## Inputs

## `testProject`

**Required** The path to the directory of the test project that needs to be tested by stryker. No default.

## Outputs

There are no outputs from this action.

## Example usage

``` yaml
# File: .github/workflows/mutation-test.yaml

on:
  # Manual run of the mutation workflow
  workflow_dispatch:

  # Scheduled run of the mutation test workflow, for example every Wednesday on 2 AM.
  schedule:
    - cron: '0 2 * * 4'

jobs:
  mutation-test:
    uses: actions/checkout@v3

    uses: tom171296/run-stryker-net@v1
      with:
        testProject: "BusinessLogic.Test/" # required
        breakAt: "75" # Optional

    uses: actions/upload-artifact@v3
    with:
      name: html-report
      path: ${{github.workspace}}/BusinessLogic.Test/StrykerOutput/**/**/*.html
```
