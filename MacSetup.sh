echo This program is designed to setup Mac computers for Inspire.

#Creates new user
echo The new username is $2 for $3. Password will be InspireMe.
sudo dscl . -create /Users/$2
sudo dscl . -create /Users/$2 UserShell /bin/bash
sudo dscl . -create /Users/$2 RealName $3
sudo dscl . -create /Users/$2 UniqueID 502
sudo dscl . -create /Users/$2 PrimaryGroupID 80
sudo dscl . -create /Users/$2 NFSHomeDirectory /Local/Users/$2
sudo dscl . -passwd /Users/$2 InspireMe
sudo dscl . -append /Groups/admin GroupMembership $2

echo Beginning installation of Homebrew, Slack, Chrome, and BeStructured software.

#Downloads Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Downloads and Installs other casks
brew tap homebrew/cask-versions

brew cask install iterm2-beta

#Installs Slack
brew cask install slack

#Installs Chrome
brew cask install google-chrome

#Uses curl to download the BeStructured file
mkdir ~/Software
curl https://concord.centrastage.net/csm/profile/downloadMacAgent/32ec6028-589e-41c8-8349-e5812e05a8aa -o ~/Software/BeStructured.zip

#Unzips the new BeStructured file
unzip -a ~/Software/BeStructured.zip

#Downloads the files
sudo installer -pkg ~/AgentSetup/CAG.pkg -target /
#You will need the password for the computer

echo The program will now install Dockutil and setup the dock.

#Adds Dockutil
brew install dockutil

#Removes/Adds icons to the dock
dockutil --remove 'Safari' --allhomes
dockutil --remove 'Mail' --allhomes
dockutil --remove 'Contacts' --allhomes
dockutil --remove 'Reminders' --allhomes
dockutil --remove 'Notes' --allhomes
dockutil --remove 'Maps' --allhomes
dockutil --remove 'Photos' --allhomes
dockutil --remove 'Messages' --allhomes
dockutil --remove 'FaceTime' --allhomes
dockutil --remove 'Keynote' --allhomes
dockutil --remove 'Pages' --allhomes
dockutil --remove 'Numbers' --allhomes
dockutil --remove 'iTunes' --allhomes
dockutil --remove 'iBooks' --allhomes
dockutil --add /Applications/Slack.app --allhomes
dockutil --add /Applications/'Google Chrome'.app --allhomes

echo The program will now rename the computer.

#Rename the computer
echo The new computer name will now be $1.
sudo scutil --set ComputerName $1
sudo scutil --set HostName $1
sudo scutil --set LocalHostName $1

#Restarts the Mac in 30 seconds
sudo shutdown -r +0.5

#Deletes the program and files
echo The program will now self destruct. Please restart after the program is terminated.
mv ~macinstaller.sh ~/Software
mv ~/AgentSetup ~/Software
rm -R ~/Software
