#!/usr/bin/env bash
set -euo pipefail

head="chore: rebuild"
body="Auto committed by a semantic-release hook"

commit="$(git show --no-patch --format="%aB" HEAD)"
[[ "$commit" == "$head\n\n$body" ]] && { echo "Running semantic-release"; exit; }

git clone https://github.com/tlvince/tlvince-semantic-release-push-dist.git deploy
cp -R dist/* deploy/dist
cd deploy
git add dist
git config user.email "tlvince-bot@tlvince.com"
git config user.name "tlvince bot"
git commit --all --message "$head" --message "$body"
echo -e "machine github.com\n  login $CI_USER_TOKEN" >> ~/.netrc
git push origin master
cd -
rm -rf deploy
echo "A new build has been pushed. You can ignore the next error :)" && exit 1
