# Linux Mint System Setup

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

## Microsoft

The Azure Functions Core Tools package comes from apt source `https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod`. The (instructions)[ https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-csharp#create-your-local-project] for adding this source don't work because the key does not match the repository.

```
Err:9 https://packages.microsoft.com/repos/microsoft-ubuntu-questing-prod questing InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY EE4D7792F748182B
```

To resolve this download the specific key from `keyserver.ubuntu.com`.

```
mkdir tmp-key
gpg --homedir "tmp-key" --keyserver keyserver.ubuntu.com --recv-keys EE4D7792F748182B
gpg --homedir "tmp-key" --export EE4D7792F748182B | gpg --dearmor -o /etc/apt/keyrings/microsoft-dev.gpg
sudo install -D -o root -g root -m 644 tmp-key/microsoft-dev.gpg /etc/apt/keyrings/microsoft-dev.gpg
```

The `questing` repository `https://packages.microsoft.com/repos/microsoft-ubuntu-questing-prod` does not contain `azure-functions-core-tools-4` so both `questing` and `noble` repositories are added as sources.

```
$ cat /etc/apt/sources.list.d/microsoft-dev.list 
deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft-dev.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-questing-prod questing main
deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-noble-prod noble main
```