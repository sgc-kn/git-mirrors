Tooling to keep our git mirrors up-to-date.

Run `just all` in the project root to update all mirrors.

This automation assumes:
1. All source repositories are public and they can be accesses without credentials.
2. The credentials in the environment variable `OPENCODE_GITLAB_CREDENTIALS` authorize to write all target repositories.

To get this running from scratch in a Github Codespace:
1. Start a fresh Codespace on `main` branch of this repository.
2. Create a personal access token in OpenCode's Gitlab, choose `read_repository` and `write_repository` permissions.
3. Create a `.env` file in the root of this repository, with one line: `OPENCODE_GITLAB_CREDENTIALS=<USER>:<TOKEN>`.

For example, my `.env` file looks like this (key rotated):

```shell
OPENCODE_GITLAB_CREDENTIALS=OC000040163666:glpat-pbJkijPQH-5DguPkydsqOm86MQp1OjN1MQk.01.0z17ynf68
```