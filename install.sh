echo $(whoami) "Let's set up your stuff"

# Check for Homebrew
# Install if is not present
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Taking homebrew ownership"
sudo mkdir /usr/local/Cellar
sudo chown -R $(whoami) /usr/local/Cellar
sudo mkdir /usr/local/Homebrew
sudo chown -R $(whoami)  /usr/local/Homebrew
sudo mkdir /usr/local/Frameworks
sudo chown -R $(whoami)  /usr/local/Frameworks
sudo install -d -o $(whoami) -g admin /usr/local/Frameworks

echo "Exporting PATH"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Update homebrew recipes
echo "Updating homebrew..."
brew update

packages=(
  azure-cli
  coreutils
  cython
  git
  git-extras
  gnupg
  icu4c
  kubernetes-cli
  mas
  oniguruma
  pinentry-mac
  pre-commit
  pypy3
  sshuttle
  tree
  watchman
  wget
)
echo "Installing Packages with brew"
brew install ${packages[@]}


apps=(
  nightowl
  docker
  evernote
  insomnia
  iterm2
  keybase
  kitematic
  kube-forwarder
  mockoon
  mongodb
  mongodb-compass-community
  robo-3t
  slack
  sourcetree
  spotify
  sublime-text
  tableplus
  )

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Adding Git config"
read -p 'Your name | user.name: ' uservar
read -p 'Your Github email | user.email: ' useremail
git config --global user.name=$uservar
git config --global user.email=$useremail
git config --global commit.gpgsign true
git config --global gpg.program gpg
git config --global core.editor "subl -n -w"

echo "Installing telepresence"
brew cask install osxfuse && brew install datawire/blackbird/telepresence

# NODE ENVIRONMENT
echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

echo "Installing node 8 via nvm"
nvm install 8

echo "Installing node 11 via nvm"
nvm install 11

echo "Adding NODE config to bash_profile"
echo '#NODE' >> ~/.bash_profile
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bash_profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bash_profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bash_profile

# JAVA ENVIRONMENT
echo "Installing AdoptOpenJDK"
brew tap AdoptOpenJDK/openjdk

echo "Installing Java8"
brew cask install adoptopenjdk8

echo "Installing Java11"
brew cask install adoptopenjdk11

echo "Installing JEnv"
brew install jenv

echo "Adding JEnv Paths to bash_profile"
echo '#JENV' >> ~/.bash_profile
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(jenv init -)"' >> ~/.bash_profile

echo "Adding Java Paths to jenv"
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/

ides=(
  intellij-idea
  visual-studio-code
  )

# Install ides to /Applications
# Default is: /Users/$user/Applications
echo "Installing IDEs with Cask"
brew cask install --appdir="/Applications" ${ides[@]}

# TODO import config for intelliJ Ultimate
# TODO import plugins for intelliJ Ultimate

# TODO import config for VsCode
# TODO import plugins for VsCode

echo "Your Slack Theme:"
echo "#21252B,#528BFF,#528BFF,#FFFFFF,#272C33,#FFFFFF,#20B684,#528BFF"
read -p "Press [Enter] key after setting this in Preferences>Sidebar..."

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up PowerLevel10k Oh My Zsh theme..."
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Setting up Spaceship Prompt theme..."
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate

echo "Installing kubetail as ZSH plugin"
git clone https://github.com/johanhaleby/kubetail.git $ZSH_CUSTOM/plugins/kubetail

echo "Installing fonts"
brew tap caskroom/fonts
brew cask install font-meslo-nerd-font

echo "Copying .zshrc"
cat .zshrc > /Users/$USER/.zshrc

echo "Copying .zshenv"
cat .zshenv > /Users/$USER/.zshenv

echo "Copying Prefs into iTerm2"
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "/Users/$USER/Github/00-dotfiles/iterm2/prefs/"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

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
