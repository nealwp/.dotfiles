del alias:gc -Force

function prompt {
    $p = Split-Path -leaf -path (Get-Location)
    "$p > "
}

function ga { git add . }
function gp { git pull }
function gP { git push }
function gs { git status }

function gc($msg) {
    git commit -m ""$msg"" 
}
