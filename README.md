Tooling to keep our git mirrors up-to-date.

Run `just` in the project root to update all mirrors.

To run this in a Github Codespace, first initialize the Codespace with `just setup` and follow the instructions.

---

I've tried to schedule this for regular execution on Github Action.
There is a draft workflow in commit 027affe5. Unfortunately, it did
not work reliably. Instead of debugging this for hours, I'll just run
the script manually for now.