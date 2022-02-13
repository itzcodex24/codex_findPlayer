fx_version "adamant"
game "gta5"


author "codex.exe#0001"
description "https://github.com/itzdrey/codex_findPlayer/blob/main/README.md"


client_scripts {
    '@vrp/client/Proxy.lua',
    '@vrp/client/Tunnel.lua',
    "client/*.lua"
}
server_scripts {
    '@vrp/lib/utils.lua',
    "server/*.lua"
}

shared_script 'config.lua'

ui_page {
    "html/index.html"
}

files {
    "html/*.*"
}