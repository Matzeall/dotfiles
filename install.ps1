$Repo = Split-Path -Parent $MyInvocation.MyCommand.Path

New-Item `
    -ItemType SymbolicLink `
    -Path "$HOME\.wezterm.lua" `
    -Target "$Repo\shared\wezterm.lua"
