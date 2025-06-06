set -euf -o pipefail

if [[ "$(pwd)" == */namecoin.org/_scripts ]]
then
    pushd ../../
else
    if [[ "$(pwd)" == */namecoin.org ]]
    then
        pushd ../
    else
        pushd ./
    fi
fi

# This script is tested and 100% working.

pushd namecoin.org
git fetch origin
COMMITS_TO_TEST=$(git shortlog --no-merges gh-pages..origin/master)
git checkout master
git merge origin/master
git checkout gh-pages
git merge origin/gh-pages
git merge master
git push origin gh-pages
git checkout master
popd

popd

echo ""
echo "The results should be available within a few seconds at:"
echo "https://namecoin.github.io/namecoin.org/"
echo "Check the website to make sure that the following commits are working as intended:"
echo "$COMMITS_TO_TEST"
