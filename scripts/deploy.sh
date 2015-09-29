#!/usr/bin/env bash
set -euo pipefail

error() { echo "$0: $1"; exit 1; }

bot_email="tlvince-bot@tlvince.com"
last_email="$(git show --no-patch --format="%aE" HEAD)"
[[ "$last_email" == "$bot_email" ]] && { echo "Running semantic-release"; exit; }

git clone https://github.com/tlvince/tlvince-semantic-release-push-dist.git deploy
cp -R dist/* deploy/dist
cd deploy
git add dist
git config user.email "$bot_email"
git config user.name "tlvince bot"
git commit --all --message "chore: rebuild"
echo -e "machine github.com\n  login $CI_USER_TOKEN" >> ~/.netrc
git push origin master
cd -
rm -rf deploy
error "A new build has been pushed. You can ignore the next error :)"
