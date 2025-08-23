
if ($Env:OS -eq "Windows_NT") {
    if (Test-Path "$Env:ALLUSERSPROFILE\pwsh\completions.ps1") {
        . "$Env:ALLUSERSPROFILE\pwsh\completions.ps1"
    }

    if (Test-Path "$Env:ALLUSERSPROFILE\pwsh\aliases.ps1") {
        . "$Env:ALLUSERSPROFILE\pwsh\aliases.ps1"
    }
}
else {
    if (Test-Path /usr/share/pwsh/completions.ps1) {
        . /usr/share/pwsh/completions.ps1
    }

    if (Test-Path /usr/share/pwsh/aliases.ps1) {
        . /usr/share/pwsh/aliases.ps1
    }
}


if (Test-Path "$Env:XDG_CONFIG_HOME/pwsh/completions.ps1") {
    . "$Env:XDG_CONFIG_HOME/pwsh/completions.ps1"
}

if (Test-Path "$HOME/.pwsh_completions.ps1") {
    . "$HOME/.pwsh_completions.ps1"
}

if (Test-Path "$Env:XDG_CONFIG_HOME/pwsh/aliases.ps1") {
    . "$Env:XDG_CONFIG_HOME/pwsh/aliases.ps1"
}

if (Test-Path "$HOME/.pwsh_aliases.ps1") {
    . "$HOME/.pwsh_aliases.ps1"
}

if ($Env:OS -eq "Windows_NT") {
    $Env:PATH = "./bin;$Env:XDG_BIN_HOME;$Env:PATH"
}
else {
    $Env:PATH = "./bin:$Env:XDG_BIN_HOME:$Env:PATH"
}