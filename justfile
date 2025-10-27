REPOS := './repos'
GITHUB_BASE := 'git@github.com:sgc-kn'
OPENCODE_BASE := 'git@gitlab.opencode.de:stadt-konstanz'

# mirror all repositories from GitHub to OpenCode
all:
  just gh-to-oc cds-examples
  just gh-to-oc dashboards
  just gh-to-oc git-mirrors
  just gh-to-oc k8s-sandbox
  just gh-to-oc konstanz-in-zahlen
  just gh-to-oc nr-flows-dwd
  just gh-to-oc nr-flows-ecocounter
  just gh-to-oc nr-flows-lubw
  just gh-to-oc nr-flows-mastr
  just gh-to-oc nr-flows-mobidata
  just gh-to-oc nr-flows-parkdaten
  just gh-to-oc nr-flows-passantenlasepeco
  just gh-to-oc nr-flows-pegelonline
  just gh-to-oc nr-flows-reporting
  just gh-to-oc nr-flows-weather
  just gh-to-oc platform
  just gh-to-oc rendezvous

# cryptography setup; run this on fresh Codespaces
setup:
  ssh-keygen -t ed25519 -f $HOME/.ssh/id_ed25519 -P "" -C "${GITHUB_USER:-$USER}@${CODESPACE_NAME:-$HOSTNAME}"
  cp ssh_known_hosts $HOME/.ssh/authorized_keys
  @echo
  @echo 'Install this public SSH key in you GitHub and OpenCode Gitlab accounts:'
  @echo
  @cat $HOME/.ssh/id_ed25519.pub
  @echo
  @echo 'Then proceed with the command: just all.'
  @echo

# update ssh_known_hosts file (careful; might enable MITM attacks)
update-cryptographic-keys:
  ssh-keyscan github.com > ssh_known_hosts
  ssh-keyscan gitlab.opencode.de >> ssh_known_hosts
  @echo 'run `cp ssh_known_hosts ~/.ssh/authorized_keys` to install the new keys'

# mirror a single repository from GitHub to OpenCode
gh-to-oc name:
  just mirror {{name}} \
    git@github.com:sgc-kn/{{name}}.git \
    git@gitlab.opencode.de:stadt-konstanz/{{name}}.git
  # it seems we're running into a rate-limit in GitHub Cloud ...
  if [ -n "$GITHUB_CODESPACE_TOKEN" ] ; then sleep 10 ; fi

# mirror a single repository between generic hosts
mirror name src dst:
  #!/usr/bin/env bash
  if [ -e {{REPOS}}/{{name}}.git ] ; then
    git -C {{REPOS}}/{{name}}.git pull
  else
    git clone {{src}} {{REPOS}}/{{name}}.git
  fi
  git -C {{REPOS}}/{{name}}.git lfs fetch --all
  git -C {{REPOS}}/{{name}}.git push {{dst}}
