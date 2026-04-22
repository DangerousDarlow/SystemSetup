Setup for macOS Tahoe.

Mac is easier to configure than Linux. I felt a list was sufficient and a script unnecessary.

1. Homebrew
2. Oh My Zsh
3. Proton Pass
4. Raindrop.io
5. Chrome
6. Obsidian
7. Insync
8. GitHub CLI
9. Git configuration
10. Visual Studio Code
11. Node Version Manager
12. DotNet SDK
13. JetBrains Toolbox
14. Docker
15. Azure CLI
16. Azure Functions CLI
17. Adobe Creative Cloud

## [Homebrew](https://docs.brew.sh/Installation)

macOS package manager
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## [Oh My Zsh](https://ohmyz.sh/#install)

zsh shell enhancement offering themes and plugins
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## [Proton Pass](https://proton.me/pass)

Password manager.
```
brew install --cask proton-pass
```

## [Raindrop.io](https://raindrop.io/download)

Bookmark management. Necessary to use the same bookmarks across browsers and devices.
```
brew install --cask raindropio
```

## [Chrome](https://www.google.com/intl/en_uk/chrome/)

Default browser for web development. Also needed to program my keyboard using [ZSA Oryx](https://configure.zsa.io/moonlander/layouts/default/latest/0).
```
brew install --cask google-chrome
```

## [Obsidian](https://obsidian.md)

Note taking tool.
```
brew install --cask obsidian
```

## [Insync](https://www.insynchq.com)

Google Drive local synchronisation. I use this to sync Google Drive folder 'Knowledge' to the local disk. This is where I keep my notes edited using Obsidian.
```
brew install --cask insync
```

The brew cash had a checksum error when I tried in April 2026 so I installed manually from https://www.insynchq.com/downloads/mac.

## [GitHub CLI](https://cli.github.com)

Makes using GitHub more straight forward.
```
brew install gh
```

After installation login.
```
gh auth login
```

## Git configuration

```
git config --global user.name "Nick Darlow"
git config --global user.email "dangerous.darlow@gmail.com" 
git config --global core.autocrlf input
```

## [Visual Studio Code](https://code.visualstudio.com)

Development tool.
```
brew install --cask visual-studio-code
```

## [Node Version Manager (nvm)](https://github.com/nvm-sh/nvm)

Install and manage versions of node.js.
```
brew install nvm
mkdir ~/.nvm
```

After installation add the following to `~/.zshrc`
```
export NVM_DIR="$HOME/.nvm"

# Load nvm
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Load nvm shell completion
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
```

Install and use node LTS
```
nvm install --lts
nvm use --lts
```

Install pnpm
```
corepack enable
corepack prepare pnpm@latest --activate
```

## [DotNet SDK](https://dotnet.microsoft.com/en-us/download)

Needed for DotNet application development.
```
brew install --cask dotnet-sdk
```


## [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)

Management of JetBrains development tools.
```
brew install --cask jetbrains-toolbox
```

## [Docker](https://www.docker.com)

Local container execution.
```
brew install --cask docker
```

## [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

Makes using Azure more straight forward.
```
brew install azure-cli
```

After installation login.
```
az login
```

My tenant is `25180d72-e3c6-409b-8b9f-24789297dc86 'Default Directory'`. Account details can be verified with
```
az account show
```

If you get an error like the following try `az login` a second time.
```
Authentication failed against tenant 25180d72-e3c6-409b-8b9f-24789297dc86 'Default Directory': AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multi-factor authentication
```

## [Azure Functions CLI](https://github.com/Azure/azure-functions-core-tools)

Makes using Azure functions more straight forward.
```
brew tap azure/functions
brew install azure-functions-core-tools@4
```

## [Adobe Creative Cloud](https://www.adobe.com/uk/creativecloud.html)

Photo editing tools Lightroom Classic and Photoshop.
```
brew install --cask adobe-creative-cloud
```
