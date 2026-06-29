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
    runs-on: ubuntu-latest

    steps:        
      - name: Check if submodules are up-to-date
        uses: LucBerge/check_submodules@latest
```

## How It Works

For each submodule, the action:

1. Gets the current commit that the submodule is pointing to
2. Identifies the default branch of the submodule's remote repository
3. Fetches the latest commit from that default branch
4. Compares the current commit with the latest commit
5. Fails if any submodule is not up-to-date
