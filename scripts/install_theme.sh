#!/usr/bin/env bash

set -e

THEME_NAME="mkdocs-material"
if [ ! -d "$THEME_NAME" ] ; then
  git clone --depth=1 ${THEME_REPO:-"https://github.com/squidfunk/mkdocs-material.git"} "$THEME_NAME"
fi