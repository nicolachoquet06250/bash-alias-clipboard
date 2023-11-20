If (-not (Test-Path "$(Get-Location)/bash-aliases-framework")) {
    git clone git@github.com:nicolachoquet06250/bash-aliases-framework.git
}

rm -rf "$(Get-Location)/bash-aliases-framework/.git/hooks/post-checkout.ps1"
ln -s "$(Get-Location)/bash-aliases-framework/.githooks/post-checkout.ps1" "$(Get-Location)/bash-aliases-framework/.git/hooks/post-checkout.ps1"
Set-ExecutionPolicy Bypass -command "$(Get-Location)/bash-aliases-framework/.githooks/post-checkout.ps1"

. "$(Get-Location)/bash-aliases-framework/.git/hooks/post-checkout.ps1" "install-script"

If (-not (Test-Path "${HOME}/.bash-alias-clipboard")) {
    $path = ""
    If ($args[1] -eq "install-script") {
        $path = "/bash-alias-clipboard"
    }
    ln -s "$(Get-Location)${path}" "${HOME}/.bash-alias-clipboard";
}

$source='source "\${HOME}/.bash-alias-clipboard/.aliases.ps1"'

If (-not (Select-String $profile -Pattern $source)) {
    Set-Content -Path $profile -Value $source
}