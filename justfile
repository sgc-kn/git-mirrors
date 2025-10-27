set dotenv-load := true
REPOS := './repos'


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


# mirror a single repository from GitHub to OpenCode
gh-to-oc name:
  just mirror {{name}} \
    https://github.com/sgc-kn/{{name}}.git \
    https://$OPENCODE_GITLAB_CREDENTIALS@gitlab.opencode.de/stadt-konstanz/{{name}}.git


# mirror a single repository between generic hosts
mirror name src dst:
  #!/usr/bin/env bash
  echo fetch...
  if [ -e {{REPOS}}/{{name}}.git ] ; then
    git -C {{REPOS}}/{{name}}.git pull
  else
    git clone {{src}} {{REPOS}}/{{name}}.git
  fi
  echo fetch git-lfs data...
  git -C {{REPOS}}/{{name}}.git lfs fetch --all
  echo push...
  git -C {{REPOS}}/{{name}}.git push {{dst}}
