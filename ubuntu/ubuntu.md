# Ubuntu System Setup

Update and upgrade apt.
```
sudo apt update && sudo apt upgrade -y
```

Install essentials.
```
sudo apt install curl git wget zsh -y
```

Install `Oh My Zsh`
```
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install Proton Pass & disable Firebox browser password manager.

https://addons.mozilla.org/en-US/firefox/addon/proton-pass/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search

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