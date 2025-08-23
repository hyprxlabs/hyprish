if ($Env:OS -eq "Windows_NT") {
    $HYPRISH_HOME = "$Env:ALLUSERSPROFILE/hyprish"
}
else {
    $HYPRISH_HOME = "$HOME/.local/share/hyprish"
}

. "$HYPRISH_HOME/profiles/pwsh/envs"
. "$HYPRISH_HOME/profiles/pwsh/aliases"
. "$HYPRISH_HOME/profiles/pwsh/functions"
. "$HYPRISH_HOME/profiles/pwsh/prompt"
. "$HYPRISH_HOME/profiles/pwsh/init"
. "$HYPRISH_HOME/profiles/pwsh/shell"
