#!/bin/sh
d=${1};
v=${2};

##  Colors
nc=$'\033[0m'               # Reset to white

# These colors are designed to mimick classic Apple colors
# Which is a teeny bit ironic, since classic Mac wasn't at all Unix
# while Brix heavily leans on modern macOS' Unixness.
# I mean, it's got an "X" in it and everything.
# That said, I just couldn't resist.
green=$'\033[1;32m'
yellow=$'\033[1;33m'
orange=$'\e[38;5;166m'
red=$'\033[1;31m'
purple=$'\033[1;35m'
blue=$'\033[1;34m'

echo "                                   ${d}

${green}                          /////   /////   //   //   //
${yellow}                         //  //  //  //  //    // //
${orange}                        /////   /////   //     ///
${red}                       //  //  //  //  //    // //
${purple}                      //  //  //  //  //   //   //
${blue}                     /////   //  //  //  //     //${nc}${v}"
