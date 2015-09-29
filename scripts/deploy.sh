#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/tlvince/tlvince-semantic-release-push-dist.git deploy
cp -R dist/* deploy/dist
cd deploy
git add dist
git config user.email "tlvince-bot@tlvince.com"
git config user.name "tlvince bot"
git commit --all --message "chore: release $npm_package_version"
echo -e "machine github.com\n  login $CI_USER_TOKEN" >> ~/.netrc
git push origin master
cd -
rm -rf deploy
