
![Brix Title](https://github.com/user-attachments/assets/790335f1-eb6f-4b97-a5e4-473054262588)

## Please be aware that running "Deploy Brix" will install [Homebrew] if it is not already installed.


### What This Is

This project's aim is modular, feature rich, human-centric declarative package management for macOS. One issue I’ve always had with Nix is it felt too much like it was made exclusively for engineers. This makes it really great for programmers and pretty inaccessible for anyone else. As such, I wanted Brix to be as simple to use as possible. The formattitng is about as simple as can be and the whole thing is deployed with by double clicking the "Deploy Brix" .command file, which then runs a shell script that does all the work.

Functionally, this is just a shell script for macOS that implements declarative package management using Homebrew as a backend. This is not a package manager per se as all the heavy lifting regarding package management is done by Homebrew. This script just automates those tasks using Homebrew’s built in commands. Since the ultimate goal of this is in part to allow it to work with mulitple package managers, it would not be unfair to refer to this as a "package manager manager," not unlike how [rEFInd] is essentially a boot manager manager.

The name is a portmanteau of “brew” (as in “Homebrew”) and “Nix.” For those unaware, Nix is a cross-platform declarative package manager. I’d gotten rather used to using it, as I use NixOS for my gaming PC, but for whatever reason I was having trouble setting it up on my last MacBook so I decided to throw this together. From my understanding macOS Nix doesn’t handle GUI based programs anyways, so there are definitely situations in which this could be used alongside Nix.

The script isn’t very complex. Honestly, I got the script essentially working in like two days and I’m not a particularly skilled programmer by any means. After that, most of my time on this was spent refining the user space and cleaning up the code.


### Usage

<img width="433" alt="Screenshot 2025-06-27 at 9 08 50 AM" src="https://github.com/user-attachments/assets/1cf6426a-5748-4f5d-8f24-14fbf4bbc0d0" />

"Brix" is self contained within its own folder (pictured above). This folder can be placed anywhere in the system. I put it in my User folder, but it will work fine wherever you put it. Just make sure you remember where it is. The configuration file is “Wall.rtf.” In this file you can list Homebrew packages that can be found at [brew.sh]. You can separate the packages by spaces or line breaks, either will work fine. I use line breaks, because I think it looks neater, but it will work the same either way. Package names must be written EXACTLY as they appear in the Homebrew repository, although capitalization does not matter.

Once the configuration is to your liking you can simply double click “Deploy Brix.” From here the script will do all the work. If Homebrew is not installed this script will install Homebrew.

Every time Brix successfully deploys a configuration it makes a backup of Wall.rtf to the Backups folder, renaming the file with the date and time of the deployment.


### How It Works

The script reads the contents of “Wall.rtf” and compares that to what Homebrew packages are currently installed. The script then uses Homebrew’s commands to install then uninstall packages accordingly.


### Why RTF files?

This is something I thought I'd address off the bat, because using a TXT formatted file would be simpler for the script to read. However, I want this to integrate into macOS as well as possiblew and in the future I intend to include multi-file configurations. As such I think users should be able to create new configuration files in TextEdit, since that's a built in macOS tool. In addition, single-file configurations may eventually be able to read formatting not supported by simple TXT files.


### Future Plans

I’d like to expand functionality to include other package managers such as [MacPorts], [Fink], [pkgin], and [Nix]/[Lix]. [MAS] would also be nice, but I don’t really know how feasible that actually is right now. I can't even get MAS to work on my system and getting it to work isn't exactly high on my on my to do list. It's hardly an essential utility.

Video game clients such as Steam, Epic, and GOG should be doable using their respective CLI clients. In addition, I’d like to include an options for user settings like login items, Dock settings, and other things of that sort in future versions.

Making this package available through Homebrew is something I'm interested in doing, although frankly (and somewhat ironically) I'm not actually sure how to "do" that. Relatedly, I'd like to make a CLI interface for people who are so inclined.

I'm also in the very near future going to make a script which will turn your Homebrew configuration into a Brix file. Probably gonna call it "xirB yolpeD."

A way to automatically update Brix is also on the good ol' master to do list as is the ability to install specific versions of packages. This is a feature included in Brew, but some work is still needed to get Brix to work well with that feature.


### Compatibily

This has only been tested with Sequoia, but presumably it should work with any version of macOS. Truth be told, it'd likely work with little to no modification on any Unix-like system so long as you have Homebrew installed. It could also be fairly easily modified to work with apt or really any other package maneger. It's designed to be pretty modular, something I intend to expand upon in further versions.


### Bug Reporting

If you have problems while using this script I ask you to first report it to this project’s GitHub page. I’ll try to help you or at least redirect you to someone who can. Since this uses Homebrew as a backend there’s a pretty good chance any problems people would have wouldn’t actually be caused by Brix itself, but I still ask you reach out to me first.

[MacPorts]: https://www.macports.org
[Lix]: https://lix.systems
[Nix]: https://nixos.org
[MAS]: https://github.com/mas-cli/mas
[brew.sh]: https://brew.sh
[Homebrew]: https://brew.sh
[rEFInd]: https://github.com/JackieXie168/rEFInd
[Fink]: https://www.finkproject.org
[pkgin]: https://pkgin.net
