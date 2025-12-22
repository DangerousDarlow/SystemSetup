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
sudo apt update
```

Install essentials.
```
sudo apt install git wget zsh -y
```

Install `Oh My Zsh`
```
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Change shell to zsh then exit and restart shell.
```
chsh -s $(which zsh)
```

Clone this repository.
```
git clone https://github.com/DangerousDarlow/SystemSetup.git
```

Run the setup script then exit and restart shell.
```
./setup.sh
```

Login to GitHub.
```
gh auth login
```