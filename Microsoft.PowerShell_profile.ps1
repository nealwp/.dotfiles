Remove-Item alias:gc -Force
Remove-Item alias:gp -Force

function prompt {
    $p = Split-Path -leaf -path (Get-Location)
    "$p > "
}

function ga { git add . }
function gp { git push }
function gs { git status }

function gc($msg) {
    git commit -m ""$msg"" 
}

function gac($msg) {
    git add . && git commit -m ""$msg""
}

function gpu() { git push -u origin (git branch --show-current) }