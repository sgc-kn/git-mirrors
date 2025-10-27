Tooling to keep our git mirrors up-to-date.

Run `just all` in the project root to update all mirrors.

To run this in a Github Codespace, do:
1. Start a fresh Codespace on `main` branch of this repository.
2. Run `just setup` and follow the instructions.
3. Run `just all` to do the actual mirroring.

Note: It seems OpenCode Gitlab is blocking (or rate-limiting) SSH access from Github's cloud infrastructure. I observe a lot of errors, that I cannot explain otherwise. This would also explain my earlier issues with Github action automation in commit 027affe5.

---

I've tried to schedule this for regular execution on Github Action.
There is a draft workflow in commit 027affe5. Unfortunately, it did
not work reliably. Instead of debugging this for hours, I'll just run
the script manually for now.