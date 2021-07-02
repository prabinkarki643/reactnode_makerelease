#!/bin/bash
echo "BASH VERSION: $BASH_VERSION"
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
magenta=`tput setaf 5`
reset=`tput sgr0`

echo "${yellow}....Making Release Started....${reset}"

# making release directory and copying core node code inside it to serve react build
mkdir release
cp -R .reactnode_makerelease/node/. ./release

# making react build
echo "${yellow}....Making React Build....${reset}"
npm run build || exit 1
echo "${green}....Build Succedded....${reset}"

# copying build to release directory
echo "${yellow}....Copying Build to release directory....${reset}"
cp -R ./build ./release

echo "${yellow}....Working on git for deploy....${reset}"
# Findout git origin
CURRENT_ORIGIN=$(git config --get remote.origin.url)
# check origin if not found exit the code
case ${CURRENT_ORIGIN-} in '') echo "$0: ${red}Please make sure you have git initialized and added the remote origin, Try again later..${reset}" >&2; exit 1;; esac
echo "ORIGIN IS: ${CURRENT_ORIGIN}"

#switching to release directory to work on git operation
cd release
# initialized git
git init
# Set remote origin
git remote set-url origin "$CURRENT_ORIGIN"

# Get prefer branch name
DEFAULT_BRANCH_NAME="frontend-release"
read -p "Enter your prefer branch-name:[default:${magenta}$DEFAULT_BRANCH_NAME${reset}] " BRANCH_NAME
BRANCH_NAME="${BRANCH_NAME:-$DEFAULT_BRANCH_NAME}"
echo "BRANCH NAME IS: ${green}$BRANCH_NAME${reset}"
read -p "${yellow}This will override the previous code in that branch, press Enter to continue${reset}"

# Do basic git operation to push
DEFAULT_COMMIT_MESSAGE="release with build"
git checkout "$BRANCH_NAME" || git checkout -b "$BRANCH_NAME"
git add .
read -p "Enter your commit message:[default:${magenta}$DEFAULT_COMMIT_MESSAGE${reset}] " COMMIT_MESSAGE
COMMIT_MESSAGE="${COMMIT_MESSAGE:-$DEFAULT_COMMIT_MESSAGE}"
echo "MESSAGE IS: ${green}$COMMIT_MESSAGE${reset}"
git commit -m "$COMMIT_MESSAGE"
git push -f origin "$BRANCH_NAME"
echo "${green}....Working on git-Finished....${reset}"

# Finished
echo "${green}Deployed successfully 😀 ,please check on your $BRANCH_NAME branch in github($CURRENT_ORIGIN)${reset}"