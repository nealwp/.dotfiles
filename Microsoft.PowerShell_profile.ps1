del alias:gc -Force
del alias:gp -Force

function prompt {
    $p = Split-Path -leaf -path (Get-Location)
    "$p > "
}

function ga { git add . }
function gp { git pull }
function gs { git status }

function gc($msg) {
    git commit -m ""$msg"" 
}

function gac($msg) {
    git add . && git commit -m ""$msg""
}

