# Editor used by CLI

if ($Env:OS -eq "Windows_NT") {
    $Env:OSTYPE = "windows"
    $Env:USER = $Env:USERNAME
    $Env:HOME = $Env:USERPROFILE
    $Env:HOSTNAME = $Env:COMPUTERNAME
    $Env:TMPDIR = "$Env:LOCALAPPDATA\Temp"

    $Env:XDG_CONFIG_HOME = if ($Env:XDG_CONFIG_HOME) { $Env:XDG_CONFIG_HOME } else { "$Env:APPDATA" }
    $Env:XDG_CACHE_HOME = if ($Env:XDG_CACHE_HOME) { $Env:XDG_CACHE_HOME } else { "$Env:LOCALAPPDATA\Temp" }
    $Env:XDG_DATA_HOME = if ($Env:XDG_DATA_HOME) { $Env:XDG_DATA_HOME } else { "$Env:LOCALAPPDATA" }
    $Env:XDG_STATE_HOME = if ($Env:XDG_STATE_HOME) { $Env:XDG_STATE_HOME } else { "$Env:LOCALAPPDATA\State" }
    $Env:XDG_RUNTIME_DIR = if ($Env:XDG_RUNTIME_DIR) { $Env:XDG_RUNTIME_DIR } else { "$Env:LOCALAPPDATA\Runtime" }
    $Env:XDG_BIN_HOME = if ($Env:XDG_BIN_HOME) { $Env:XDG_BIN_HOME } else { "$Env:LOCALAPPDATA\Programs\bin" }
}
else {
    $Env:REPOS_PATH = if ($Env:REPOS_PATH) { $Env:REPOS_PATH } else { "$HOME/repos" }
    $Env:XDG_CONFIG_HOME = if ($Env:XDG_CONFIG_HOME) { $Env:XDG_CONFIG_HOME } else { "$HOME/.config" }
    $Env:XDG_CACHE_HOME = if ($Env:XDG_CACHE_HOME) { $Env:XDG_CACHE_HOME } else { "$HOME/.cache" }
    $Env:XDG_DATA_HOME = if ($Env:XDG_DATA_HOME) { $Env:XDG_DATA_HOME } else { "$HOME/.local/share" }
    $Env:XDG_STATE_HOME = if ($Env:XDG_STATE_HOME) { $Env:XDG_STATE_HOME } else { "$HOME/.local/state" }
    $Env:XDG_RUNTIME_DIR = if ($Env:XDG_RUNTIME_DIR) { $Env:XDG_RUNTIME_DIR } else { "/run/user/$([System.Environment]::GetFolderPath("UserProfile"))" }
    $Env:XDG_BIN_HOME = if ($Env:XDG_BIN_HOME) { $Env:XDG_BIN_HOME } else { "$HOME/.local/bin" }
}

$Env:DEV_HOME = if ($Env:DEV_HOME) { $Env:DEV_HOME } else { "$HOME/dev" }
$Env:DEV_CONFIG_HOME = if ($Env:DEV_CONFIG_HOME) { $Env:DEV_CONFIG_HOME } else { "$Env:XDG_CONFIG_HOME/dev" }
$Env:DEV_CACHE_HOME = if ($Env:DEV_CACHE_HOME) { $Env:DEV_CACHE_HOME } else { "$Env:XDG_CACHE_HOME/dev" }
$Env:DEV_DATA_HOME = if ($Env:DEV_DATA_HOME) { $Env:DEV_DATA_HOME } else { "$Env:XDG_DATA_HOME/dev" }
$Env:DEV_STATE_HOME = if ($Env:DEV_STATE_HOME) { $Env:DEV_STATE_HOME } else { "$Env:XDG_STATE_HOME/dev" }
$Env:DEV_RUNTIME_DIR = if ($Env:DEV_RUNTIME_DIR) { $Env:DEV_RUNTIME_DIR } else { "$Env:XDG_RUNTIME_DIR/dev" }   
$Env:DEV_BIN_HOME = if ($Env:DEV_BIN_HOME) { $Env:DEV_BIN_HOME } else { "$Env:XDG_BIN_HOME" }

$Env:EDITOR = if ($Env:EDITOR) { $Env:EDITOR } else { "nvim" }
$Env:SUDO_EDITOR = if ($Env:SUDO_EDITOR) { $Env:SUDO_EDITOR } else { $Env:EDITOR }
$Env:BAT_THEME = if ($Env:BAT_THEME) { $Env:BAT_THEME } else { "ansi" }

if (Test-Path "$Env:XDG_CONFIG_HOME/pwsh/envs.ps1") {
    . "$Env:XDG_CONFIG_HOME/pwsh/envs.ps1"
}