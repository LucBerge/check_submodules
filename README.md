# Check Submodules

This action verifies that each submodule in your repository is pointing to the latest commit of its remote default branch. It's useful for ensuring your submodules don't fall behind their upstream repositories.

## Usage

```yaml
name: Check Submodules
on:
  schedule:
    - cron: '0 0 * * 0'  # Runs weekly on Sundays at midnight
  push:
  workflow_dispatch:

jobs:
  check-submodules:
    runs-on: [orchestrator-runner]

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        
      - name: Check if submodules are up-to-date
        uses: LucBerge/check_submodules@master
```

## Create your workflow from template

1. On the Github interface, go to the repository where you want to add this action
2. Click on the "Actions" tab
3. Click on "New workflow"
4. Select the "Check Submodules" template from the list
5. Click on "Start commit" to create the workflow file in your repository

## How It Works

For each submodule, the action:

1. Gets the current commit that the submodule is pointing to
2. Identifies the default branch of the submodule's remote repository
3. Fetches the latest commit from that default branch
4. Compares the current commit with the latest commit
5. Fails if any submodule is not up-to-date
