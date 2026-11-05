
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Start-Process "C:\Program Files\TxGameAssistant\AppMarket\AppMarket.exe" #Or insert your Gameloop installed path.

$Targets = @("GameDownload", "GameLoopSetup", "Setup")

Write-Host "GameLoop master window allowed. Monitoring strictly for background installers..." -ForegroundColor Cyan
Write-Host "Press CTRL+C to close this monitor when you are finished playing."

# 3. Endless loop running every 200 milliseconds to catch the silent deployment
while ($true) {
    foreach ($Process in $Targets) {
        $Running = Get-Process -Name $Process -ErrorAction SilentlyContinue
        if ($Running) {
            Stop-Process -Name $Process -Force
            Write-Host "[!] Silent update agent ($Process.exe) was intercepted and terminated!" -ForegroundColor Yellow
        }
    }
    Start-Sleep -Milliseconds 200
}
