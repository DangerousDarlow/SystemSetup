## Firefox

Install `Proton Pass` extension & disable browser password manager.

https://addons.mozilla.org/en-US/firefox/addon/proton-pass/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search


Install `floccus` extension.

https://addons.mozilla.org/en-US/firefox/addon/floccus/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search

Sync `floccus` with Google Drive. Name the profile 'Default'. You don't need to login to Google prior to configuring the extension.

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

Change shell to zsh then exit and restart the shell.
```
chsh -s $(which zsh)
```

Clone this repository.
```
git clone https://github.com/DangerousDarlow/SystemSetup.git
```

Install [Visual Studio Code](https://code.visualstudio.com/). Installation will add the vscode source and key to apt.

Run the setup script then exit and restart shell.
```
./setup.sh
```

Login to GitHub.
```
gh auth login
```

Download the latest JetBrains toolbox archive from https://www.jetbrains.com/toolbox-app/ then run the setup script. Exit and restart the shell.
```
./jetbrains.sh
```

Run JetBrains toolbox and install applications.

```
jetbrains-toolbox
```

## DotNet

The Microsoft packages repository does not contain all dotnet runtimes. At the time of writing it had 8 and 10 but not 9. 9 needs to be installed for back ports according to these [instructions](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install).