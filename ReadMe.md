Windows personal / gaming PC setup and configuration.

Install WSL
>`wsl --install`

Set default WSL version
>`wsl --set-default-version 2`

Update Winget
>https://apps.microsoft.com/detail/9nblggh4nns1?rtc=1&hl=en-gb&gl=GB

Install Winget UI
>`winget install SomePythonThings.WingetUIStore`

Install packages with Winget (use package file)

Test Docker
>`docker run hello-world`

Install latest Node
>`nvm install latest`
>`nvm use {}`

Configure Git
>`git config --global user.email "dangerous.darlow@gmail.com"`
>`git config --global user.name "Nick Darlow"`

Check nuget sources
>`dotnet nuget list source`

Add nuget source if necessary
>`dotnet nuget add source --name nuget.org https://api.nuget.org/v3/index.json`