set -eu -o pipefail
shopt -s failglob

DEPLOY_GHPAGES=0

echo "You've already deployed to the github.io site, right?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) DEPLOY_GHPAGES=1; break;;
    esac
done

if [[ "${DEPLOY_GHPAGES}" == "1" ]]
then
    echo ""
    echo "Deploying to github.io..."
    echo ""
    bash ./deploy_ghpages.sh
    echo ""
    echo "Is everything working properly at github.io?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) break;;
            No ) exit 1;;
        esac
    done
fi

echo ""

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

pushd namecoin.info
git fetch origin
git checkout beta
git merge origin/beta
OLD_REVISION=$(git log -1 --format=oneline | grep -oE '[^ ]+$')
echo "$OLD_REVISION" | grep -E -e '\b([a-f0-9]{40})\b' -
popd
pushd namecoin.org
git fetch origin
git checkout master
git merge origin/master
COMMITS_TO_TEST=$(git shortlog --no-merges $OLD_REVISION..master)
JEKYLL_REVISION="$(git rev-parse --verify master)"
echo "$JEKYLL_REVISION" | grep -E -e '\b([a-f0-9]{40})\b' -
popd
JEKYLL_VM=offline-namecoin-jekyll-deploy
qvm-copy-to-vm "$JEKYLL_VM" ./namecoin.org

echo ""
echo "Open a terminal in the Jekyll VM, and run the following:"
echo "bash ~/QubesIncoming/anon-13-git-github-wip/namecoin.org/_scripts/deploy_jekyll_vm.sh"
read -p "Press Enter when you've done this."

rm -rf ./namecoin.info/*
JEKYLL_BUILT_FILES="$HOME""/QubesIncoming/""$JEKYLL_VM""/_site/*"
cp -a $JEKYLL_BUILT_FILES ./namecoin.info/
rm -rf "$HOME""/QubesIncoming/""$JEKYLL_VM""/_site"
pushd namecoin.info
git add .
git commit --message="Updated based on Jekyll build of $JEKYLL_REVISION"
git push origin beta
git checkout master
popd

popd

echo ""
echo "Finished!  The results should be available within 1 hour at:"
echo "https://beta.namecoin.org/"
echo "Check the website to make sure that the following commits are working as intended:"
echo "$COMMITS_TO_TEST"
