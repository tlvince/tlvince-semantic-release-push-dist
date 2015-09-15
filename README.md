# tlvince-semantic-release-push-dist

> Reduced test case for committing dist with semantic-release

Want semantic-release to build and commit dist? Here's one approach:

1. Initialise semantic-release with your repo as normal
2. Generate a new GitHub access token (only repo/public_repo scope is required)
3. Run `travis env set CI_USER_TOKEN [token]`
4. Add a npm build script that's suitable for your project
5. Copy [scripts/deploy.sh][] into your project and adjust it for your needs
6. Add it as an npm deploy script
7. Add a predeploy script that runs the npm build script
8. Call `npm run deploy` after `semantic-release pre`

That's it!

See this repository as a working example.

**Pro tip**: create a machine/bot account on GitHub (generate a access token
for this account) and add it as a collaborator (with push access) to your repo.

**Pro tip**: add `scripts/deploy.sh` to your `.npmignore`.

[scripts/deploy.sh]: scripts/deploy.sh

## Author

© 2015 Tom Vincent <github@tlvince.com> (https://tlvince.com)

## License

Released under the [MIT License][].

[mit license]: http://tlvince.mit-license.org
