Chocolatey - Windows Software Management Automation
===

Chocolatey is a package manager for Windows (like apt-get or yum in Linux). It was designed to be a decentralized framework for quickly installing applications and tools that you need. Package manager and software packages can be installed as described in Chocolatey website. 

* [Chocolatey Installation](https://chocolatey.org/install)
* [Chocolatey Packages](https://chocolatey.org/packages)

The purpose of this script is to simplify and automate the package installation, by installing Chocolatey package manager and any desired package in one go through a self-elevated PowerShell prompt.

```
chocolatey-install-packages.ps1 package 
                                [[package] 
                                ...
                                [package]]
```

## Install Packages Automatically

1. Open PowerShell prompt  
1. Run script `.\chocolatey-install-packages.ps1` followed by space sepaarted list of packages to install
1. Script will automatically install Chocolatey and the listed packages

For example the below command will install git, VS Code and Google Chrome on the machine where it is executed. See [Chocolatey Packages](https://chocolatey.org/packages) for more available packages.

```
.\chocolatey-install-packages.ps1 git vscode googlechrome
```

## Installation Scenarios

`Scenarios` subfolder contains `.bat` files with predefined installation scenarios, for simple and easy repeatability. Theses are useful for example when setting up similar environments during test and development work. 

## Predefine Installation Scenarios

1. Add a new .bat file in scenarios subfolder
1. Edit the .bat file
1. Add a line referring to executing `powershell chocolatey-install-packages.ps1` , followed by the packages you want to install
1. Now you have a easy repeatable instalaliton by just running the .bat file

For example the below .bat file content will install git, VS Code and Google Chrome on the machien where it is executed. See [Chocolatey Packages](https://chocolatey.org/packages) for more available packages.


```
powershell ..\chocolatey-install-packages.ps1 git vscode googlechrome
```

## License

This project is provided "AS IS", without any warranty, under the MIT License - see the [LICENSE](LICENSE) file for details    
