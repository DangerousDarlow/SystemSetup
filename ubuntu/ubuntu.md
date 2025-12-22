# Ubuntu System Setup

## Firefox

Install Proton Pass extension & disable browser password manager.

https://addons.mozilla.org/en-US/firefox/addon/proton-pass/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search


Install floccus extension.

https://addons.mozilla.org/en-US/firefox/addon/floccus/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search

Sync floccus with Google Drive.

## Shell

Update and upgrade apt.
```
sudo apt update && sudo apt upgrade -y
```

Install essentials.
```
sudo apt install curl git vim wget zsh -y
```

Install `Oh My Zsh`
```
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Change shell to zsh, exit and restart shell.
```
chsh -s $(which zsh)
```

Configure Git.
```
git config --global user.name "Nick Darlow"
git config --global user.email "dangerous.darlow@gmail.com" 
git config --global core.autocrlf input
```

Install GitHub CLI.

https://github.com/cli/cli/blob/trunk/docs/install_linux.md

Login to GitHub.
```
gh auth login
```

Clone this repository.
```
git clone https://github.com/DangerousDarlow/SystemSetup.git
```

Run the setup script.
```
./setup.sh
```