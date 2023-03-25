#!/bin/bash

find_scope() {
  local path="$1"
  local file="$2"

  if [[ -f "$path/$file" ]]; then
    echo "$path" && return
  elif [[ "$path" != '.' ]]; then
    find_scope "$(dirname "$path")" "$file"
  fi
}

find_scope_names() {
  local paths="$@"

  for path in $paths; do
    find_scope "$path" 'Dockerfile'
  done
}

find_scope_names $1 | sort -u | sed "s/^$2\///"
