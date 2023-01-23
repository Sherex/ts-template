#!/bin/bash
# TODO: Check that project directory exists and users has access rights

if ! command -v git > /dev/null; then
  echo 'Missing required dependency "git"'
  exit 5
fi

TEMPLATE_REPOSITORY="https://github.com/Sherex/ts-template"
PROJECTS_DIRECTORY=${PROJECTS_DIRECTORY:-$PWD}
PROJECT_NAME=$1
VALID_PROJECT_NAME='^[a-zA-Z0-9_\-]+$'

echo 'Creating a new project..'
echo "  From \"$TEMPLATE_REPOSITORY\""
echo "  To \"$PROJECTS_DIRECTORY\""

if [[ ! $PROJECT_NAME =~ $VALID_PROJECT_NAME ]]; then
  echo ""
  echo "Invalid project name \"$PROJECT_NAME\""
  echo "Please specify name as first argument. Exiting..."
  exit 1
fi

# BUG: `read` is skipped when piping from curl.
# while [[ ! $PROJECT_NAME =~ $VALID_PROJECT_NAME ]]; do
#   read -e -p 'Enter a project name: ' PROJECT_NAME
#   if [[ $PROJECT_NAME =~ $VALID_PROJECT_NAME ]]; then
#     break
#   fi
#   echo 'Please input a valid name'
# done

echo "Creating project in \"$PROJECTS_DIRECTORY/$PROJECT_NAME\"..."

echo -n "Cloning repository... "
cd "$PROJECTS_DIRECTORY"
git clone -q $TEMPLATE_REPOSITORY $PROJECT_NAME
echo "Done!"

echo "Reinitializing local git repository... "
cd $PROJECT_NAME
rm -rf .git
git init -q
rm create.sh
