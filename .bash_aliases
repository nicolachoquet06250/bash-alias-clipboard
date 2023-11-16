#!/bin/bash

function clipboard() {
  if [[ "${ALIASES_FRAMEWORK_DEFINED}" == "" ]];then
    echo ""
    echo "❌ Le framework d'aliases n'est pas importé !"
    echo ""
    return
  fi
	
  declare -A trad=(
    ['unknown_command-fr_FR']="La commande '${chosen_command}' n'existe pas"
    ['unknown_command-en_US']="Command ${chosen_command} not found"
  )

  function help() {
  	commands_lines=(
  	    "clipboard copy \"value\""
  	)

  	framework_create_help "clipboard" "${commands_lines[@]}"
  }
  eval "$(framework_sub_command -n "help")"
	
  function copy() {
    echo "$1"|tr -d '\n' | xclip -selection clipboard;
    echo "$1"|tr -d '\n' | xclip -selection primary;
  }
  eval "$(framework_sub_command -n "copy")"

  eval "$(framework_run --with-help --error "$(__ unknown_command)")"
}
