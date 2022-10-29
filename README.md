# Run Stryker for .Net GiHub action

This action runs [Stryker for .Net](https://stryker-mutator.io/docs/stryker-net/introduction/) on your specified test project.

## Inputs

### `testProject`

**Required** The path to the directory of the test project that needs to be tested by Stryker. No default.

### `breakAt`

**Optional** Set the minimal mutation score threshold for the action to succeed. If the threshold is not met, the action will fail the pipeline. The default value is `0`. 

## Outputs

There are no outputs from this action.

## Example usage

``` yaml
# File: .github/workflows/mutation-test.yaml

on:
  # Run the mutation tests when changes are pushed to the main branch
  push:
    branches:
      - 'main'
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
