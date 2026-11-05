## GameLoop Auto-Update Interceptor & Performance Fix

This lightweight PowerShell script prevents **GameLoop** from force-installing background beta or client updates that trigger severe performance drops, keymapping bugs, and FPS stuttering in games like *PUBG Mobile*.

### The Problem
Traditional mitigation steps (like blocking internet access for `AppMarket.exe` or denying folder-write permissions across the entire directory) often break the emulator entirely or fail when background helper components bypass firewall rules. 

GameLoop splits its architecture: while `AppMarket.exe` handles the primary UI window, it silently spawns standalone processes (`GameDownload.exe` and `Setup.exe`) to pull down patch binaries in the background and overwrite files without user consent.

### How This Script Works
This script safely isolates the main emulation engine while strictly targeting the silent installation payload:

1. **Self-Elevation (Auto-Admin):** Automatically requests Administrator privileges via a UAC prompt upon execution, removing the need to manually open an elevated terminal.
2. **Safe Launch:** Safely initializes GameLoop using its explicit structural directory path.
3. **Targeted Interception Loop:** Enters a high-frequency asynchronous sweep (scanning every 200ms) to monitor active system processes.
4. **Zero-Impact Termination:** The millisecond `GameDownload`, `GameLoopSetup`, or `Setup` launch under GameLoop's context, the script kills them instantly. This prevents incoming updates from writing to disk while leaving the active emulator interface completely untouched.

### Setup & Usage
1. Install Gameloop again and make sure after installation not to open the app.
2. Open the script file and ensure the installation path matches your correct drive configuration (e.g., `C:\`, `D:\`, or `G:\`).
3. Right-click `gameloop.ps1` and select **Run with PowerShell**.
4.If the script doesn't execute, make sure you set the bypass execution policy for scripts via this command: "Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass" or using the script "powershell.exe -ExecutionPolicy Bypass -File .\gameloop.ps1"
5. Make sure when Gameloop opens to go to settings and set the auto run at startup as unchecked.
6. Accept the UAC prompt. Keep the script window open or minimized while playing your game.
7. Close the console window when your gaming session is complete to stop the background loop.
