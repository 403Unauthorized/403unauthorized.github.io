#!/usr/bin/env bash
# Push HTML files to gh-pages automatically.

# Fill this out with the correct org/repo
AUTHOR=Torres.Lei
REPO=yongqilei.github.io
# This probably should match an email for one of your users.
EMAIL=leiyongqi1026@gmail.com
INSTALL_THEME='./scripts/install_theme.sh'

set -e

chmod +x $INSTALL_THEME && $INSTALL_THEME