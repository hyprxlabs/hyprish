if ($Env:OS -eq "Windows_NT") {
    $HYPRISH_HOME = "$Env:ALLUSERSPROFILE/hyprish"
}
else {
    $HYPRISH_HOME = "$HOME/.local/share/hyprish"
}

. "$HYPRISH_HOME/profiles/pwsh/rc.ps1"