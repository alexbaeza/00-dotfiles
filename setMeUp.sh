echo $(whoami) "Let's set up your stuff"

# Check for Homebrew
# Install if is not present
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Taking homebrew ownership"
sudo chown -R $(whoami) /usr/local/Cellar
sudo chown -R $(whoami)  /usr/local/Homebrew/
sudo install -d -o $(whoami) -g admin /usr/local/Frameworks

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Adding Git config"
git config --global user.name=Alejandro B
git config --global user.email=alejandro.baeza@enginegroup.com

echo "Installing git-extras"
brew install git-extras

echo "Installing wget"
brew install wget

echo "Installing Mac App Store-cli (mas-cli)"
brew install mas

echo "Installing Spark Email Client via mas-cli"
mas install 1176895641

# TODO install evernote
# TODO install keybase
# TODO install docker
# TODO install kitematic
# TODO install mongoDbCompass
# TODO install imsoniaREST
# TODO install kubeforwarder
# TODO install mockoon

echo "Installing IDEs"
# TODO install intelliJIdea
# TODO import config for intelliJIdea

# TODO install VSCode
# TODO import config for Vscode

echo "Installing wget"
brew install wget

# TODO Finish intalling this
# echo "Installing TablePlus"
# wget https://tableplus.io/release/osx/tableplus_latest

apps=(
  filezilla
  firefox
  google-chrome
  sourcetree
  spotify
  iterm2
  sublime-text
  slack
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up Oh My Zsh theme..."
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Downlading Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Installing fonts"
brew tap caskroom/fonts
brew cask install font-meslo-nerd-font

# TODO ADD iTerm2 config
# com.googlecode.iterm2.plist
# Specify the preferences directory
# defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
# defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
sudo pmset -a sms 0

#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

#"Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

killall Finder

echo "All Done, go write some code !"