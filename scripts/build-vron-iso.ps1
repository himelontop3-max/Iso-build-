$ErrorActionPreference = "Stop"

$Root = "C:\VRONBuild"
$Source = "$Root\ISO"
$Output = "$Root\VRON-OS-v2.0-LTSC2021.iso"

$Oscdimg = "${env:ProgramFiles(x86)}\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg\oscdimg.exe"

if (!(Test-Path $Oscdimg)) {
    throw "Oscdimg not found. Install Windows ADK Deployment Tools."
}

if (!(Test-Path "$Source\boot\etfsboot.com")) {
    throw "BIOS boot file missing."
}

if (!(Test-Path "$Source\efi\microsoft\boot\efisys.bin")) {
    throw "UEFI boot file missing."
}

if (!(Test-Path "$Source\sources\$OEM$\$1\VRON\VRON.Shell.exe")) {
    throw "VRON executable missing."
}

& $Oscdimg `
    -m -o -u2 -udfver102 `
    "-bootdata:2#p0,e,b$Source\boot\etfsboot.com#pEF,e,b$Source\efi\microsoft\boot\efisys.bin" `
    $Source `
    $Output

if (!(Test-Path $Output)) {
    throw "ISO creation failed."
}

Write-Host "VRON ISO CREATED: $Output" -ForegroundColor Green
