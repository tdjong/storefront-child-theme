#!/bin/sh
# zip for easy deploy to running wordpress instance
# using git commands

VERSIONFILE=style.css
# show old version and write new version
echo Previous version:
OLDVERSION=`grep -i Version $VERSIONFILE`
echo $OLDVERSION
# split out only version number with AWK
# echo $OLDVERSION | awk '{print $2}'

echo -n "Please enter new version number: "
read version

if [ "$version" != "" ]; then
    # Replace whole line and not just version number, 
    # we don't want to replace this number elsewhere
  sed -i -e "s/$OLDVERSION/Version:\t\t$version/" $VERSIONFILE
fi

git diff
read -p "Press enter to continue" key

git log --oneline > changelog.txt
git commit -a -m "Bump to version $version"

# zip for installation via wordpress interface
git archive -v --format zip --prefix storefront-child/ -o ../storefront-child.zip HEAD
