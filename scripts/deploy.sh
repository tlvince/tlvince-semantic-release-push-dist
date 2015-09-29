#!/usr/bin/env bash
set -euo pipefail

error() { echo "$0: $1"; exit 1; }

[[ "$TRAVIS" ]] || error "Not running in Travis"
[[ "$TRAVIS_PULL_REQUEST" == "false" ]] || error "Not publishing pull requests"
[[ "$TRAVIS_BRANCH" == "master" ]] || error "Not in the master branch"
[[ "$TRAVIS_REPO_SLUG" == "tlvince/tlvince-semantic-release-push-dist" ]] || {
  error "Not publishing in forks"
}

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
