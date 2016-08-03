#!/usr/bin/env bash

warn() {
  echo "WARNING: $1" >&2
}


warn "$0 is deprecated and will be removed."
warn "Please run \`hr vimbundle\` directly."
echo

$PWD/hr/bin/hr vimbundle
