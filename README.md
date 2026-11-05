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
1. Open the script file and ensure the installation path matches your correct drive configuration (e.g., `C:\`, `D:\`, or `G:\`).
2. Right-click `gameloop.ps1` and select **Run with PowerShell**.
3. Accept the UAC prompt. Keep the script window open or minimized while playing your game.
4. Close the console window when your gaming session is complete to stop the background loop.
