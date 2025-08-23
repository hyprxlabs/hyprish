

if ($null -ne (Get-Command mise -ErrorAction SilentlyContinue)) {
    mise activate pwsh | Invoke-Expression
}

if ($null -ne (Get-Command zoxide -ErrorAction SilentlyContinue)) {
    zoxide init pwsh | Invoke-Expression
}

if ($null -ne (Get-Command fzf -ErrorAction SilentlyContinue)) {
    if (Test-Path /usr/share/fzf/completion.bash) {
        . /usr/share/fzf/completion.bash
    }
    if (Test-Path /usr/share/fzf/key-bindings.bash) {
        . /usr/share/fzf/key-bindings.bash
    }
}