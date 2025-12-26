set -euf -o pipefail

cd ~/QubesIncoming/anon-13-git-github-wip/

pushd namecoin.org
jekyll build
qvm-copy-to-vm anon-13-git-github-wip ./_site
popd
rm -rf namecoin.org

sudo poweroff
