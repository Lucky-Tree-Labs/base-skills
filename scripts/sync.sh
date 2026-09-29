#!/usr/bin/env bash
# Pull the skills createbases.com publishes into skills/, so this repository
# mirrors the site rather than holding a second copy that drifts. The site's
# discovery index is the source; a skill it stops listing is removed here.
set -euo pipefail
ORIGIN="${BASE_ORIGIN:-https://createbases.com}"
INDEX="$ORIGIN/.well-known/skills/index.json"
cd "$(dirname "$0")/.."

if ! index=$(curl -fsSL "$INDEX"); then
  echo "no index at $INDEX; leaving skills/ as it is"
  exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
echo "$index" | python3 -c '
import json, sys
for skill in json.load(sys.stdin)["skills"]:
    for f in skill["files"]:
        print(skill["name"] + "\t" + f)
' | while IFS=$'\t' read -r name file; do
  case "$name/$file" in *..*|/*) echo "refusing path $name/$file"; exit 1;; esac
  mkdir -p "$tmp/$name/$(dirname "$file")"
  curl -fsSL "$ORIGIN/.well-known/skills/$name/$file" -o "$tmp/$name/$file"
done

[ -n "$(ls -A "$tmp")" ] || { echo "index listed no skills; leaving skills/ as it is"; exit 0; }
rm -rf skills
mv "$tmp" skills
trap - EXIT
echo "synced: $(ls skills | tr '\n' ' ')"
