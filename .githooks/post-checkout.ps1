If (-not (Test-Path "$(Get-Location)/bash-aliases-framework")) {
    git clone git@github.com:nicolachoquet06250/bash-aliases-framework.git
}

Remove-Item -Recurse -Force "$(Get-Location)/bash-aliases-framework/.git/hooks/post-checkout.ps1"
New-Item -ItemType SymbolicLink -Path "$(Get-Location)/bash-aliases-framework/.git/hooks/post-checkout.ps1" -Target "$(Get-Location)/bash-aliases-framework/.githooks/post-checkout.ps1"

powershell "$(Get-Location)/bash-aliases-framework/.git/hooks/post-checkout.ps1" "install-script"

If (-not (Test-Path "${HOME}/.bash-alias-clipboard")) {
    If ($args[0] -eq "install-script") {
        $path = "/bash-alias-clipboard"
        New-Item -ItemType SymbolicLink -Path "${HOME}/.bash-alias-clipboard" -Target "$(Get-Location)${path}"
    }
}
