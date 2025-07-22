#!/bin/sh
cd "$( dirname -- "$0"; )";
cp .wall Wall.rtf

revision="$(date '+%Y.%m.%d@%H.%M.%S')";	# Grab date.

#	 Brew
grab_brews () {
#	read -a b <<<
	b=$(brew list --installed-on-request);
}

#	 Grab Casks
grab_casks () {
#	read -a
	c=$(brew list --cask);
}

#	 Grab Installed Packages
#	 This figures out which configs it's working with and goes from there
grab_installed () {
	##	Config grabbing
	grab_brews;
	grab_casks;

	# Combine the above grabs.
	string=( "${b}" );
	string=( "${string} ${c}" );

	# Turn string into an array
	read -a installed <<< $string;
}

grab_installed;

echo "//	Generated on $revision"\\ >> Wall.rtf;
echo "\\" >> Wall.rtf;

for i in ${installed[@]}
do
	echo "$i"\\ >> Wall.rtf;
done

echo "}" >> Wall.rtf
