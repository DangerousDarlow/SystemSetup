Setup for Windows 11.

## Installer

Create Windows 11 installation media using Microsoft tools
https://www.microsoft.com/en-gb/software-download/windows11

During Windows 11 installation the installer prompts to connect to the Internet. By default this cannot be skipped and if a connection is established signing into a Microsoft account is compulsory. To avoid this and install using a local account press `Shift + F10` to open a command prompt. Enter command `oobe\bypassnro`. After the installer restarts when the Internet connection step is reached there will be an option to proceed without connecting.

## After Installation

Connect to WiFi / network.

Install Windows Updates.

Enable full disk encryption using BitLocker. Open `Control Panel > System and Security > BitLocker Drive Encryption`. Select `Turn BitLocker on`.

Enable Windows Hello using `Settings > Accounts > Sign-in options`.

Install `UniGetUI` from the Microsoft Store.

Using UniGetUI install

1. Brave (Brave.Brave)
2. Google Chrome (Google.Chrome)
3. Proton Pass (Proton.ProtonPass)
4. Proton Mail (Proton.ProtonMail)
5. Notepad++ (Notepad++.Notepad++)
6. Paint.net (dotPDN.PaintDotNet)

Configure Proton Pass application and browser extensions. Use biometrics / PIN to unlock.

Disable browser password manager and auto fill.