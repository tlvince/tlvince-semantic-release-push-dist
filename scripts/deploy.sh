#!/usr/bin/env bash
set -e

git clone https://github.com/tlvince/tlvince-semantic-release-push-dist.git deploy
mv dist/* deploy/dist
cd deploy
git add .
git config user.email "tlvince-bot@tlvince.com"
git config user.name "tlvince bot"
git commit --all --message "$npm_package_version"
echo -e "machine github.com\n  login $CI_USER_TOKEN" >> ~/.netrc
git push origin master
