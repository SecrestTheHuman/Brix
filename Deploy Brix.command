#!/bin/sh
##	##	This script makes Brix work
##	##	You should really not be modifying it if you don't know what you're doing.
##	##	Proceed at your own risk.

cd "$( dirname -- "$0"; )";	 # Move shell to the script's folder
							# This would generally be the "Brix" folder

version=$(cat .support/version);	# Version stored as string to be used in "Header"

dir=$( pwd );				 # Grab directory name as variable, used in "Header"

f=Wall.rtf;	 # For now this is hardcoded, it will be more flexible in future
				# This is the config file.

revision="$(date '+%Y.%m.%d@%H.%M.%S')";	# Grab date.
							# This will be the local revision designation

##	Make default commands
#	 Can be changed so Brix can be used for other package managers
pm=brew;					#	Package manager command
i=install;					#	Install
u=uninstall;				#	Uninstall
l=list;						#	List

##	Grab global language
lang=$( locale | grep LANG | sed 's/.*\=\"//' | sed 's/\..*//' )

##	Initialize variables
#	These will be turned into strings later if there are changes to make
#	Otherwise if they remain empty that will tell the script there are no changes
to_uninstall=();
to_install=();

								############
								# MESSAGES #
								############

##	Import all the messages from the localizations folder
msg () {						#	1 is the massage ID, 2 is the any text that appears after.
	./.support/localizations/master $1 $2;
}

	##	##	##	##	##	##	##	##
	##	##	##	HEADER	##	##	##
	##	##	##	##	##	##	##	##
	
	##	Just aesthetic stuff at the top

##	Brix Logo
.support/logo.command $(msg deploying) "  $version";

echo;
msg evaluating $dir;
echo;

##	Check if Wall.rtf is present.
if [ ! -f ${f} ]
then
	msg error_no_file;
	exit 1;
fi

# #	Check if "Homebrew is installed and if it is not install Homebrew
if [[ $(command -v brew) == "" ]]
then
	msg error_no_brew;
	echo;
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

		####### ##	##	##	##	 ####	######	##	 ####	##	##	 ####
		##		##	##	### ##	##	##	  ##	##	##	##	### ##	##	 #
		####	##	##	## ###	##		  ##	##	##	##	## ###	  ##
		##		##	##	##	##	##	##	  ##	##	##	##	##	##	#	##
		##		 ####	##	##	 ####	  ##	##	 ####	##	##	 ####

	##	##	Below are custom functions that are later called to do the things	##	##

						##	##	##	##	##	##	##	##	##	##
						##	##	The "GRAB" functions	##	##
						##	##	##	##	##	##	##	##	##	##
						
	##	These grab different information from various places in the system

							##	##	##	##	##	##	##	##
							##	Grab new configuration	##
							##	##	##	##	##	##	##	##

##	Grab RTF file
#	 Grabs RTF file in local folder as specified through argument
#	 Can also be used for txt files, which will be supported in future.
grab_rtf () {
	f=$1;
#	string=$(cat $f | sed 's/\\cf0//' | sed 's/;.*//g' | sed 's/\\.*//g' | sed 's/{.*//g' | sed 's/}.*//g' | awk '{print tolower($0)}');
 
		#| sed 's/;.*//g' | sed 's/\\.*//g' | sed 's/{.*//g' | sed 's/}.*//g' | awk '{print tolower($0)}');

	## Convert rtf into array
	## Convert config file into array, clean with "sed" then lowercase it all with "awk"
	read -a new_config <<< $(cat $f | sed 's/\\cf0//' | sed 's/\/\/.*//g' | sed 's/\\.*//g' | sed 's/{.*//g' | sed 's/}.*//g' | awk '{print tolower($0)}');
}

							##	##	##	##	##	##	##	##	##
							##	Grab current configuration	##
							##	##	##	##	##	##	##	##	##

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

						##	##	##	##	##	##	##	##
						##	 DEPLOYMENT FUNCTIONS	##
						##	##	##	##	##	##	##	##

##	Sort packages into to install and to uninstall
sort_packages () {
	for pkg in ${array[@]};
	do
		if [[ $(echo ${installed[@]} | fgrep -w $pkg) ]]
		then
			to_uninstall+=" ${pkg}";
		else
			to_install+=" ${pkg}";
		fi
	done
}

					##	##	Deploys the configuration
#	 This runs the install and uninstall command once with all changed packages listed in command
deploy_config () {
	if [ -n "${to_install}" ];
	then
		echo;
		msg install;
		echo;
		${pm} ${i} $to_install;
		echo;
		msg installed;
	fi
	
	if [ -n "${to_uninstall}" ];
	then
		echo;
		msg uninstall;
		echo;
		${pm} ${u} $to_uninstall;
		echo;
		msg uninstalled;
	fi
}

##	Backs up the config file
backup_config () {
	cp Wall.rtf Backups/${revision}.rtf
}

						###	BRING IT TOGETHER	###

##	Grabs both the current and new configs
grab_installed;
grab_rtf ${f};

# Compare arrays and make new array of the differences
array=(`echo ${new_config[@]} ${installed[@]} | tr ' ' '\n' | sort | uniq -u `);

if [ ${#array[@]} -eq 0 ];	# If no changes
then
	msg no_changes;
	exit 1;
else						# If yes changes
	msg revision "$revision";
fi

##	Sort packages into uninstall and install
sort_packages;

##	Install packages
deploy_config;
backup_config;

echo;
echo "Done!";
