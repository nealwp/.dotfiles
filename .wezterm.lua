local wezterm = require('wezterm')

local function list_repos()
    local repos = {}
    local success, stdout, _ = wezterm.run_child_process({
        'cmd.exe',
        '/c',
        'dir',
        '/b',
        'C:\\Users\\preston.neal\\source'
    })

    if success then
        for repo in stdout:gmatch("[^\r\n]+") do
            table.insert(repos, { label = repo, id = 'C:\\Users\\preston.neal\\source\\' .. repo })
        end
    end
    return repos
end

local function get_git_branch(pane)
    local cwd = pane:get_current_working_dir()
    if not cwd then
        return "no cwd"
    end

    local success, stdout, _ = wezterm.run_child_process({
        'git',
        '-C',
        cwd.file_path:gsub("/", "", 1),
        'rev-parse',
        '--abbrev-ref',
        'HEAD',
    })

    if success then
        local branch = stdout:gsub("\n", "")
        if branch ~= "" then
            return branch
        end
    end
    return ""
end

local function sessionizer(window, pane)
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
end

local config = wezterm.config_builder()

config.default_prog = { 'c:/Program Files/Git/bin/bash.exe', '--login' }
config.font = wezterm.font('CaskaydiaMono NF', { weight = 'Regular' })
config.font_size = 10.5
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.window_decorations = 'RESIZE'
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.status_update_interval = 500
config.color_scheme = 'Catppuccin Mocha'
config.window_padding = {
    left = 1,
    right = 1,
    top = 3,
    bottom = 0,
}

config.keys = {
    {
        key = 'c',
        mods = 'LEADER',
        action = wezterm.action.SpawnTab('CurrentPaneDomain')
    },
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.EmitEvent('toggle-session-picker')
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
        action = wezterm.action_callback(sessionizer)
    }
}

wezterm.on('toggle-session-picker', function(window, pane)
    local workspaces = wezterm.mux.get_workspace_names()
    local choices = {}

    for _, workspace in ipairs(workspaces) do
        table.insert(choices, { label = workspace, id = workspace })
    end

    window:perform_action(
        wezterm.action.InputSelector({
            title = "sessions",
            description = "select a session",
            choices = choices,
            action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
                if id then
                    inner_window:perform_action(
                        wezterm.mux.set_active_workspace(id)
                    )
                end
            end)
        }),
        pane
    )
end)


wezterm.on('update-status', function(window, pane)
    local time = wezterm.strftime "%H:%M"
    local date = wezterm.strftime "%m/%d/%Y"
    local branch = get_git_branch(pane)
    local workspace = wezterm.mux.get_active_workspace()

    window:set_right_status(wezterm.format({
        { Text = '  ' .. workspace },
        { Foreground = { Color = "#ffcc00" } },
        { Text = '  ' .. branch },
        { Foreground = { Color = "#cccccc" } },
        { Text = '  ' .. time .. '  ' .. date },
    }))
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local is_active = tab.is_active
    local fg_color = is_active and "#00ff00" or "#777777"
    local bg_color = "#222222"
    local index = tab.tab_index + 1


    local process = tab.active_pane.foreground_process_name or "shell"
    local process_name = process:match("([^/\\]+)$") or process

    local title = '';
    if string.find(process, 'mason') then
        title = 'nvim'
    else
        title = process_name:gsub(".exe", "")
    end


    return wezterm.format({
        { Foreground = { Color = fg_color } },
        { Background = { Color = bg_color } },
        { Text = ' ' .. index .. ':' .. title .. ' ' }
    })
end)

return config
