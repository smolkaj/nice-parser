#!/bin/bash
# From https://github.com/simonjbeaumont/ocaml-travis-gh-pages

set -e
# Make sure we're not echoing any sensitive data
set +x
set -o errexit -o nounset

if [[ -z "$TRAVIS" || "$TRAVIS_PULL_REQUEST" != "false" || "$TRAVIS_BRANCH" != "master" ]]; then
  echo "[docgen] This is not a push-to-master Travis build, doing nothing..."
  exit 0
else
  echo "[docgen] Updating docs on Github pages..."
fi

DOCSRC=$(opam config var ${PACKAGE}:build)/_build/default/_doc/_html
DOCDIR=.gh-pages
rm -rf $DOCDIR

# Error out if $GH_TOKEN is empty or unset
: ${GH_TOKEN:?"GH_TOKEN need to be uploaded via travis-encrypt"}

git clone https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG} $DOCDIR 2>&1 | sed -e "s/$GH_TOKEN/!REDACTED!/g"
git -C $DOCDIR checkout gh-pages || git -C $DOCDIR checkout --orphan gh-pages

DOCFILES=$(echo $DOCSRC/*)
cp -R $DOCFILES $DOCDIR

git -C $DOCDIR config user.email "travis@travis-ci.org"
git -C $DOCDIR config user.name "Travis"
git -C $DOCDIR add .
git -C $DOCDIR commit --allow-empty -m "Travis build $TRAVIS_BUILD_NUMBER pushed docs to gh-pages"
git -C $DOCDIR push origin gh-pages 2>&1 | sed -e "s/$GH_TOKEN/!REDACTED!/g"
echo "[docgen] updated docs successfully!"

