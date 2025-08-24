git log --format='%aN' | sort -u | while read author; do
    echo "$author"
    git log --author="$author" --pretty=tformat: --numstat |
    grep -v "package-lock.json" |
    awk '{ added += $1; removed += $2; } END { printf "  Added: %s\n  Removed: %s\n", added, removed }'
done
