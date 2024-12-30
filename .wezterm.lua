local wezterm = require('wezterm')
local io = require('io')

local function list_repos()
    local repos = {}
    local handle = io.popen('dir /b C:\\Users\\preston.neal\\source')
    if handle then
        for repo in handle:lines() do
            table.insert(repos, { label = repo, id = 'C:\\Users\\preston.neal\\source\\' .. repo })
        end
        handle:close()
    end
    return repos
end

local config = wezterm.config_builder()

wezterm.on('update-right-status', function(window, pane)
    local time = wezterm.strftime "%H:%M"
    local date = wezterm.strftime "%m/%d/%Y"

    window:set_right_status(wezterm.format {
        { Text = time .. '  ' .. date },
    })
end)

config.font = wezterm.font('CaskaydiaMono NF', { weight = 'Regular' })
config.font_size = 10.5
config.default_prog = { 'c:/Program Files/Git/bin/bash.exe', '--login' }
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = 'TITLE | RESIZE'
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
    {
        key = 'c',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab('CurrentPaneDomain')
    },
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.ShowLauncherArgs({ flags = 'WORKSPACES' })
    },
    {
        key = 'l',
        mods = 'META',
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        key = 'h',
        mods = 'META',
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        key = 'f',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
            local choices = list_repos()

            window:perform_action(
                wezterm.action.InputSelector({
                    action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
                        if not id and not label then
                            return
                        else
                            inner_window:perform_action(
                                wezterm.action.SwitchToWorkspace({
                                    name = label,
                                    spawn = {
                                        cwd = id
                                    }
                                }),
                                inner_pane
                            )
                        end
                    end),
                    title = 'sessionizer',
                    choices = choices,
                    description = 'select a repo to open in a workspace',
                }),
                pane
            )
        end)
    }
}

return config
