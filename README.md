# Run Stryker for .Net github action

This actions runs [Stryker for .Net](https://stryker-mutator.io/docs/stryker-net/introduction/) on your specified test project.

## Inputs

## `testProject`

**Required** The path to the directory of the test project that needs to be tested by stryker. No default.

## Outputs

There are no outputs from this action.

## Example usage

```
uses: tom171296/test-action-hacktober@v1
with:
    testProject: "Minor.Nijn.Test/"
```
