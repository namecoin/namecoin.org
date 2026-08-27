set -euf -o pipefail

DEPLOY_BETA=0

echo "You've already deployed to the beta site, right?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) DEPLOY_BETA=1; break;;
    esac
done

if [[ "${DEPLOY_BETA}" == "1" ]]
then
    echo ""
    echo "Deploying to beta..."
    echo ""
    bash ./deploy_beta.sh
    echo ""
    echo "Is everything working properly at beta?"
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
git checkout master
git merge origin/master
git merge beta
git push origin master
popd

popd

echo ""
echo "Finished!  The results should be available within 1 hour at:"
echo "https://www.namecoin.org/"
echo ""
echo "If needed, post about the change on:"
echo "* Reddit"
echo "* Twitter"
