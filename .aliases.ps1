function clipboard {
    If ("${ALIASES_FRAMEWORK_DEFINED}" -eq $null) {
        Write-Output ""
        Write-Output "❌ Le framework d'aliases n'est pas importé !"
        Write-Output ""
        return
    }

    $trad = @{
        'unknown_command-fr_FR' = "La commande '${chosen_command}' n'existe pas"
        'unknown_command-en_US' = "Command ${chosen_command} not found"
    }

    function help {
        return $(framework_create_help "clipboard" @('clipboard copy "value"'))
    }
    Invoke-Expression $(framework_sub_command -n "help")

    function copy {
        Write-Output "${args[1]}"|tr -d '\n' | xclip -selection clipboard;
        Write-Output "${args[1]}"|tr -d '\n' | xclip -selection primary;
    }
    Invoke-Expression $(framework_sub_command -n "copy")

    Invoke-Expression $(framework_run --with-help --error "$(__ unknown_command)")
}