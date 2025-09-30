REPOS := './repos'
GITHUB_BASE := 'git@github.com:sgc-kn'
OPENCODE_BASE := 'git@gitlab.opencode.de:stadt-konstanz'

all:
  just gh-to-oc cds-examples
  just gh-to-oc dashboards
  just gh-to-oc git-mirrors
  just gh-to-oc k8s-sandbox
  just gh-to-oc konstanz-in-zahlen
  just gh-to-oc nr-flows-dwd
  just gh-to-oc nr-flows-ecocounter
  just gh-to-oc nr-flows-lubw
  just gh-to-oc nr-flows-mobidata
  just gh-to-oc nr-flows-parkdaten
  just gh-to-oc nr-flows-passantenlasepeco
  just gh-to-oc nr-flows-pegelonline
  just gh-to-oc nr-flows-reporting
  just gh-to-oc nr-flows-weather
  just gh-to-oc platform
  just gh-to-oc rendezvous

gh-to-oc name:
  just mirror {{name}} \
    git@github.com:sgc-kn/{{name}}.git \
    git@gitlab.opencode.de:stadt-konstanz/{{name}}.git

mirror name src dst:
  #!/usr/bin/env bash
  if [ -e {{REPOS}}/{{name}}.git ] ; then
    git -C {{REPOS}}/{{name}}.git pull
  else
    git clone {{src}} {{REPOS}}/{{name}}.git
  fi
  git -C {{REPOS}}/{{name}}.git lfs fetch --all
  git -C {{REPOS}}/{{name}}.git push {{dst}}
