# Check that arguments exist, and Exit script if missing
if(!$args.length) {
    Write-Host -ForegroundColor red "Please define Chocolatey packages as parameters to enable installation of the packages.`n"
    Write-Host -ForegroundColor green "See https://chocolatey.org/packages for available package options.`n`nFor example install git and vscode by adding their package names as paramters; `n .\chocolatey-install-online.ps1 git vscode"    
    break
}

# Self elevate to administrator mode if needed
if(![bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
    $MyInvocation.MyCommand.Path
    Start-Process PowerShell -verb runas -ArgumentList '-NoExit', '-File',$MyInvocation.MyCommand.Path, "$args"
    break
} 

$choco_exists   = @()
$choco_packages = @()

# Validate that argument packages exist in Choco repository
for($i=0;$i -lt $args.Length;$i++) {
    
    Write-Progress -Activity "Looking for Chocolatey packages... " `
                   -PercentComplete $((($i+1)/$args.Length)*100) `
                   -CurrentOperation $args[$i]

    $arg = $args[$i]
    $choco_packages += $args[$i] #$arg
    $choco_exists   += [bool](choco search "$arg" | Where-Object {$_ -like "$arg *"})
}

# Check for Chocolatey environment variable as proof of existing installation
if(![environment]::GetEnvironmentVariable("ChocolateyInstall")) {
    Write-Host "Choclatey does not appear to be installed. Installing it now..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# List any misisng package
$missing=0
for($i=0;$i -lt $choco_packages.Length;$i++) {    
    $package = $choco_packages[$i]
    if(!$choco_exists[$i]) {
        $missing++
        Write-Host -ForegroundColor RED "$package does not exist."
    } 
}

# Allow stopping due to missing packages
if ($missing) {
    $continue = Read-Host -Prompt "$missing requested package(s) could not be found. Do you still want to continue? (Y/N)"
    if(!($continue -eq "Y")) { break } 
}

# Install existing packages 
for($i=0;$i -lt $choco_packages.Length;$i++) {    
    if($choco_exists[$i]) {
        Write-Host -ForegroundColor Green "Installing $($choco_packages[$i])..." 
        choco install $($choco_packages[$i]) --yes --limit-output
    }    
}