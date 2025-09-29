Tooling to keep our git mirrors up-to-date.

Run `just` in the project root to update all mirrors.

---

This is scheduled for regular execution as a GitHub action. In order for
this to work, you have to configure a repository secret
`SSH_PRIVATE_KEY` with a secret SSH Key which has access to all source
and destination repositories, as configured in the `justfile`. To
generate such a key, run the following commands:

```shell
ssh-keygen -t ed25519 -f /tmp/id
cat /tmp/id
```

Then copy the output into the repository secret `SSH_PRIVATE_KEY` and
configure the **public** part of the key as SSH key for a sufficiently
privileged user on all source and destination forges.

```shell
cat /tmp/id.pub
```

Beware, that anyone with write-access to the `main` branch of this
repository will be able to extract this SSH key and use it to access and
modify all code in the associated forge accounts. Thus you should use
dedicated accounts for this.

In the unlikely case that either the source or the destination rotates
their SSH keys, you have to update their public keys in
`ssh_known_hosts`. You can do this with `just update-known-hosts`.
Verify this out-of-band, to protect yourself against man-in-the-middle
attacks.
