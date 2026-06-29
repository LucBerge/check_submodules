# Init all submodules
git submodule update --init

# Create temp file
TEMP_FILE=$(mktemp)

# For each submodule, check status
git submodule foreach '# Function to check if submodule is up-to-date
    # Get current commit in submodule
    current_commit=$(git rev-parse HEAD)
    echo "  Current commit: $current_commit"

    # Get default branch name from remote
    default_branch=$(git remote show origin | grep "HEAD branch" | cut -d ":" -f 2 | xargs)
    echo "  Default branch: $default_branch"

    # Fetch latest from remote
    git fetch --quiet origin $default_branch

    # Get latest commit on default branch
    latest_commit=$(git rev-parse origin/$default_branch)
    echo "  Latest remote commit: $latest_commit"

    # Compare commits
    if [ "$current_commit" != "$latest_commit" ]; then
        echo "  ❌ Submodule $name is NOT up-to-date"
        echo "ERROR" >> "'"$TEMP_FILE"'"
    else
        echo "  ✅ Submodule $name is up-to-date"
    fi
    echo ""
'

# Check if any errors were recorded
if [ -s "$TEMP_FILE" ]; then
    echo "❌ One or more submodules are NOT up-to-date with their remote default branches"
    exit 1
else
    echo "✅ All submodules are up-to-date with their remote default branches"
fi
rm -f "$TEMP_FILE"
