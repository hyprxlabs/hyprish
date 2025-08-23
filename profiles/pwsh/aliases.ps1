# File system

$global:CD_HOOKS = @()

Remove-Alias "alias" -ErrorAction SilentlyContinue
Set-Alias "alias" "Set-Alias"
$hasZoxide = $null -ne (Get-Command z -ErrorAction SilentlyContinue)

if ($Env:OS -eq "Windows_NT") {
    Remove-Alias ls -ErrorAction SilentlyContinue
    Remove-Alias cd -ErrorAction SilentlyContinue
    Remove-Alias open -ErrorAction SilentlyContinue
}

Remove-Alias gcm -ErrorAction SilentlyContinue

$hasOpen = $null -ne (Get-Command open -ErrorAction SilentlyContinue)

# ls
function Invoke-Ls { eza -lh --group-directories-first --icons=auto $args }
Set-Alias ls Invoke-Ls
function ff { fzf --preview "bat --style=numbers --color=always {}" $args }
set-alias ff Invoke-FF


function Invoke-ChangeDirectory {
    $a = $args
    if ($a.Count -eq 0) {
        Set-Location ~
    }
    elseif (Test-Path $a[0] -PathType Container) {
        Set-Location $a[0]
    }
    else {
        if (-not $hasZoxide) {
            Set-Location $a[0]
        }
        z $a   
    }

    $loc = Get-Location
    foreach ($item in $global:CD_HOOKS) {
        $item.Invoke($loc)
    }
}


set-alias cd Invoke-ChangeDirectory


function Invoke-Open {
    if ($hasOpen) {
        open $args
    }
    else {
        Start-Process $args
    }
}

set-alias open Invoke-Open


# Directories
function Invoke-CdBackOne { Set-Location .. }
function Invoke-CdBackTwo { Set-Location ../.. }
function Invoke-CdBackThree { Set-Location ../../.. }

set-alias .. Invoke-CdBackOne
set-alias ... Invoke-CdBackTwo
set-alias .... Invoke-CdBackThree

# Docker
set-alias d='docker'

# xtask
function Invoke-XtaskRun { xtask run $args }
function Invoke-XtaskExec { xtask build $args }
function Invoke-XtaskLs { xtask list $args }

xtask
set-alias xt='xtask'
set-alias xtr='Invoke-XtaskRun'
set-alias xte='Invoke-XtaskExec'
set-alias xtl='Invoke-XtaskLs'

# terraform

function Invoke-TerraformPlan { terraform plan $args }
function Invoke-TerraformApply { terraform apply $args }
function Invoke-TerraformDestroy { terraform destroy $args }
function Invoke-TerraformFmt { terraform fmt $args }
function Invoke-TerraformValidate { terraform validate $args }
function Invoke-TerraformInit { terraform init $args }

set-alias tf='terraform'
set-alias tfp='Invoke-TerraformPlan'
set-alias tfa='Invoke-TerraformApply'
set-alias tfd='Invoke-TerraformDestroy'
set-alias tfs='Invoke-TerraformState'
set-alias tfv='Invoke-TerraformValidate'
set-alias tfi='Invoke-TerraformInit'


function Invoke-NeoVim {
    if ($args.Count -eq 0) {
        nvim .
    }
    else {
        nvim $args
    }
}
set-alias n='Invoke-NeoVim'


# GIT
function Invoke-GitCommit { git commit -m $args }
function Invoke-GitCommitAll { git commit -a -m $args }
function Invoke-GitCommitAmend { git commit -a --amend $args }

function Invoke-GitStatus { git status $args }
function Invoke-GitLog { git log --oneline --graph --decorate --all $args }
function Invoke-GitPush { git push $args }
function Invoke-GitPull { git pull $args }
function Invoke-GitAdd { git add $args }
function Invoke-GitAddAll { git add . $args }
set-alias g='git'
set-alias gcm Invoke-GitCommit
set-alias gcam Invoke-GitCommitAll
set-alias gcad Invoke-GitCommitAmend
set-alias gst Invoke-GitStatus
set-alias gl Invoke-GitLog
set-alias gp Invoke-GitPush
set-alias gpl Invoke-GitPull
set-alias ga Invoke-GitAdd
set-alias gaa Invoke-GitAddAll


# dotnet
function Invoke-DotNetRun { dotnet run $args }
function Invoke-DotNetBuild { dotnet build $args }
function Invoke-DotNetTest { dotnet test $args }

function Invoke-DotNetAddPackage { dotnet package add $args } 
function Invoke-DotNetAddRef { dotnet reference add $args }

set-alias nt "dotnet"
set-alias ntr Invoke-DotNetRun
set-alias ntb Invoke-DotNetBuild
set-alias ntt Invoke-DotNetTest
set-alias ntpa   Invoke-DotNetAddPackage
set-alias ntra Invoke-DotNetAddRef


# deno 
function Invoke-DenoRun { deno run $args }
function Invoke-DenoTest { deno test $args }
function Invoke-DenoFmt { deno fmt $args }
function Invoke-DenoTask { deno lint $args }

set-alias dn "deno"
set-alias dnr Invoke-DenoRun
set-alias dnf Invoke-DenoFmt
set-alias dnt Invoke-DenoTask


$Env:HOSTFILE = "/etc/hosts"
if ($Env:OS -eq "Windows_NT") {
    $Env:HOSTFILE = "$env:windir\System32\drivers\etc\hosts"
}

function Invoke-EditHostFile {
    if ($Env:OS -eq "Windows_NT") {
        & "$EDITOR" $Env:HOSTFILE
    }
    else {
        sudo "$SUDO_EDITOR" $Env:HOSTFILE
    }
}
set-alias ehosts Invoke-EditHostFile

function Invoke-IsElevated {
    if ($Env:OS -eq "Windows_NT") {
        $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }
    else {
        return $(id -u) -eq 0
    }
}
set-alias is_admin Invoke-IsElevated