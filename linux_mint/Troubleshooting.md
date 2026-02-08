## Firefox Crashes

I experienced repeated Firefox crashes on a newly installed system. As soon as the browser was started it would freeze for tens of seconds. I was unable to identify the problem. I tried

- Turning off recommended performance settings in Firefox general settings
- Reinstalling Firefox; apt and flatpak
- Uninstalling extensions

I noticed high CPU usage by process `wireplumber` which I killed.

The problem seems to have resolved itself.