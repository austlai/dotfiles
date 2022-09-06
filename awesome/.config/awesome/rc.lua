-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- {{ Required library.
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library.
local gears         =   require("gears") --Utilities such as color parsing and objects.
local awful         =   require("awful") --Everything related to window managment.
                        require("awful.autofocus")

-- Widget and layout library.
local wibox         =   require("wibox")

-- Theme handling library.
local beautiful     =   require("beautiful")

-- Notfication library.
local naughty       =   require("naughty")
naughty.config.defaults['icon_size'] = 100

-- Menubar
local menubar = require("menubar")

-- Other libraries
local lain          =   require("lain")
local freedesktop   =   require("freedesktop")

-- Enabling hotkey help widget for VIM and other apps
-- when client with a matching name is openend:
local hotkeys_popup =   require("awful.hotkeys_popup").widget
                        require("awful.hotkeys_popup.keys")
local myTable       =   awful.util.table or gears.table -- 4.{0,1} compatibility
-- }}

-- {{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config.
if awful.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title  = "Oops, there were errors during startup!",
                     text   = awesome.startup_errors })
end

-- Handle runtime errors after startup.
do
local inError = false
awesome.connect_signal("debug::error", function (error)
    -- To avoide endless error loop.
    if inError then return end
    inError = true

    naughty.notify({ preset = naughty.config.presets.critical,
                     title  = "Oops, an error happened!",
                     text   = tostring(error) })
    inError = false
end)
end
-- }}

-- {{ To autostart windowsless processes.
local function runOnce(cmdArr)
    for _, cmd in ipairs(cmdArr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

runOnce({ "unclutter -root" }) -- Entries must be comma-separated.
-- }}

local themes = {
    "eos-default", --1
}

-- {{ Choosing your theme.
local themeChosen = themes[1] -- Number is from the above list. Replace with your selected number.
local pathOfTheme = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), themeChosen)
beautiful.init(pathOfTheme)
-- }}

-- {{ Modkeys
local modkey    = "Mod4"
local altkey    = "Mod1"
local ctrl      = "Control"
-- }}

-- {{ awesome variables
awful.util.terminal     = "alacritty"

-- Tage names
-- Use this for reference : https://fontawesome.com/cheatsheet

awful.util.tagnames = {  "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }

-- {{ Layouts
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    awful.layout.suit.floating,
}

awful.util.taglist_buttons = myTable.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = myTable.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = 250}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", themeChosen))
-- }}

-- {{ Menu
local awesomeMainMenu = {
    { "Hotkeys", function() return false, hotkeys_popup.show_help end },
    { "Manual", "alacritty" .. " -e 'man awesome'" },
    { "Arandr", "arandr" },
    { "Restart", awesome.restart },
}

-- Buiulding the right click menu.
awful.util.rcMainMenu = freedesktop.menu.build({
    before = {
        { "Awesome", awesomeMainMenu },
        --{ "Awesome", awesomeMainMenu, beautiful.awesome_icon }
        --{ "Atom", "atom" },
        -- Other traids can be put here.

    },
    after = {
        { "Terminal", "alacritty" },
        { "Log out", function() awesome.quit() end},
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
        -- Other triads can be put here.
    }
})

-- Menubar configuration.
menubar.utils.terminal = "alacritty" -- Set the terminal for application that needs it.
-- }}

-- {{ Wallpaper
-- Re-sets the wallpaper when a screen's geometry changes (e.g. Different resolution).
screen.connect_signal("property::geometry", function(s)
    --Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen.
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
-- }}

-- Create a wibox for each screen and add it.
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- {{ Mouse bindings.
root.buttons(myTable.join(
    awful.button({ }, 3, function () awful.util.rcMainMenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}

-- {{ Key bindings
local globalKeys = myTable.join(
    -- {{ Personal keybindings.
    -- Awesome menubar
    awful.key({ modkey }, "o", function () menubar.show() end,
        {description = "Show awesome menubar.", group = "Hotkeys"}),
    awful.key({ modkey }, "w", function () awful.util.rcMainMenu:show() end,
        {description = "Show the main menu.", group = "Hotkeys"}),

    -- Awesome
    awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {description = "Launches this help.", group="Awesome"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        {description = "Reloads awesome.", group="Awesome"}),
    awful.key({ modkey, "Shift" }, "q", function () awful.spawn.with_shell( "killall awesome" ) end,
        {description = "Quit awesome.", group="Awesome"}),

    -- Show/Hide top wibox
    awful.key({ modkey, "Shift" }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
    {description = "Toggle top wibox.", group = "Awesome"}),

    awful.key({ modkey }, "n", function () awful.util.spawn( "firefox" ) end,
        {description = "Launch firefox", group = "Hotkeys"}),
    awful.key({ modkey }, "m", function () awful.util.spawn( "thunar" ) end,
        {description = "Launch thunar", group = "Hotkeys" }),
    awful.key({ modkey }, "Return", function () awful.util.spawn( "alacritty" ) end,
        {description = "Launch the terminal.", group="Hotkeys"}),
    awful.key({ modkey }, "t", function () awful.spawn.with_shell( "wpg -m" ) end,
        {description = "Cycle theme", group="Hotkeys"}),
    awful.key({ modkey }, "d", function () awful.spawn.with_shell( "rofi -modi drun -show drun -display-drun 'Apps : ' -line-padding 4 -columns 2 -padding 50 -hide-scrollbar -show-icons -drun-icon-theme 'Arc-X-D' -font 'Noto Sans Regular 11'" ) end,
        {description = "Launch rofi", group="Hotkeys"}),

    -- Screenshots
    awful.key({ }, "Print", function () awful.util.spawn( "maim ~/Pictures/screenshots/$(date +%s).png" ) end,
        {description = "Take screenshot", group = "Screenshots" }),
    awful.key({ "Shift" }, "Print", function () awful.util.spawn( "maim ~/Pictures/screenshots/$(date +%s).png" ) end,
        {description = "Take screenshot", group = "Screenshots" }),

    -- Layout switching
    awful.key({ altkey, "Shift" }, "l", function () awful.tag.incmwfact( 0.05) end,
        {description = "Increase master width factor.", group = "Layout"}),
    awful.key({ altkey, "Shift" }, "h", function () awful.tag.incmwfact(-0.05) end,
        {description = "Decrease master width factor.", group = "Layout"}),
    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "Increase the number of master clients.", group = "Layout"}),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "Decrease the number of master clients.", group = "Layout"}),
    awful.key({ modkey, ctrl }, "h", function () awful.tag.incncol( 1, nil, true) end,
        {description = "Increase the number of columns.", group = "Layout"}),
    awful.key({ modkey, ctrl }, "l", function () awful.tag.incncol(-1, nil, true) end,
        {description = "Decrease the number of columns.", group = "Layout"}),
    awful.key({ modkey }, "space", function () awful.layout.inc( 1) end,
        {description = "select next", group = "Layout"}),
    awful.key({ modkey, "Shift"}, "space", function () awful.layout.inc(-1) end,
        {description = "select previous", group = "Layout"}),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus down.", group = "Client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus up.", group = "Client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus left.", group = "Client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "Focus right.", group = "Client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "Swap with next client by index.", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "Swap with previous client by index.", group = "Client"}),
    awful.key({ modkey, ctrl }, "j", function () awful.screen.focus_relative( 1) end,
        {description = "Focus the next screen.", group = "Screen"}),
    awful.key({ modkey, ctrl }, "k", function () awful.screen.focus_relative(-1) end,
        {description = "Focus the previous screen.", group = "Screen"}),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
        {description = "Jump to urgent client", group = "Client"}),
    awful.key({ ctrl }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Go back.", group = "Client"}),

    -- On the fly useless gaps change
    awful.key({ altkey, ctrl}, "j", function () lain.util.useless_gaps_resize(1) end,
              {description = "Increment useless gaps.", group = "Tag"}),
    awful.key({ altkey, ctrl }, "k", function () lain.util.useless_gaps_resize(-1) end,
              {description = "Decrement useless gaps.", group = "Tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "Add new tag.", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "Move tag to the left.", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "Move tag to the right", group = "Tag"}),
    awful.key({ modkey, "Shift" }, "y", function () lain.util.delete_tag() end,
              {description = "Delete tag", group = "Tag"}),

    -- Retore window
    awful.key({ modkey, ctrl }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "Restore minimized.", group = "Client"}),

    -- Misc
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute("amixer -D pulse sset Master 5%+")
            beautiful.volume.update() end,
            {description = "Volume up.", group = "Misc"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute("amixer -D pulse sset Master 5%-")
            beautiful.volume.update() end,
            {description = "Volume down.", group = "Misc"}),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("pamixer -t"))
            beautiful.volume.update() end,
            {description = "Volume mute toggle.", group = "Misc"}),
    awful.key({ }, "XF86MonBrightnessUp",
        function ()
            os.execute(string.format("xbacklight +5"))
            end,
            {description = "Brightness Up", group = "Misc"}),
    awful.key({ }, "XF86MonBrightnessDown",
        function ()
            os.execute(string.format("xbacklight -5"))
            end,
            {description = "Brightness down", group = "Misc"})

    -- }}
)

local clientKeys = myTable.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client,
              {description = "Magnify client", group = "Client"}),
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "Toggle fullscreen", group = "Client"}),
    awful.key({ modkey }, "q", function (c) c:kill() end,
              {description = "Close", group = "Hotkeys"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle,
              {description = "Toggle floating", group = "Client"}),
    awful.key({ modkey, ctrl }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "Move to master", group = "Client"}),
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end,
              {description = "Toggle keep on top", group = "Client"}),
    awful.key({ modkey }, "Down",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "Minimize", group = "Client"}),
    awful.key({ modkey }, "Up",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "Maximize", group = "Client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "View tag #", group = "Tag"}
        descr_toggle = {description = "Toggle tag #", group = "Tag"}
        descr_move = {description = "Move focused client to tag #", group = "Tag"}
        descr_toggle_focus = {description = "Toggle focused client on tag #", group = "Tag"}
    end
    globalKeys = myTable.join(globalKeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, ctrl }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctrl, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

local clientButtons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- }}

-- {{ Set keys
root.keys(globalKeys)
-- }}

-- {{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will matched to these rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientKeys,
                     buttons = clientButtons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebar
    { rule_any = { type = { "dialog", "normal" } },
        properties = { titlebars_enabled = false } },

    -- Set applications to always map on the tag 1 on screen 1.
    -- find class or role via xprop command
    --{ rule = { class = browser },
      --properties = { screen = 1, tag = awful.util.tagnames[1] } },

    -- Set applications to always map on the tag 2 on screen 1 with tag switching.
    -- find class or role via xprop command
    --{ rule = { class = terminal },
      --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    -- Set applications to always map on the tag 3 on screen 2 with tag switching.
    -- find class or role via xprop command
    --{ rule = { class = terminal },
      --properties = { screen = 2, tag = awful.util.tagnames[3], switchtotag = true  } },

    -- Set applications to be maximized at startup with floating disabled.
    -- find class or role via xprop command
    { rule = { class = "thunar" },
        properties = { maximized = true, floating = true } },
    { rule = { class = "code" },
        properties = { maximized = false, floating = false } },
    { rule = { class = "Arandr" },
        properties = { maximized = false, floating = false } },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "yad", -- For yad windows.
            },
            class = {
                "Galculator",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "Yad"
            },
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, properties = { floating = true }
    },

    -- Floating clients but centered in screen
    {
        rule_any = {
            class = {
                "Polkit-gnome-authentication-agent-1",
                "Arcolinux-calamares-tool.py"
            },
        },
        properties = { floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    }
}
-- }}

-- {{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}

-- {{ Autostart applications
awful.spawn.with_shell(
       'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
       'xrdb -merge <<< "awesome.started:true";' ..
        "nm-applet" ..
        "numlockx on" ..
        "feh --bg-fill ~/Pictures/wallpapers/*" ..
        "xset s 480 dpms 600 600 600" ..
        --"dbus-launch dunst -config ~/.config/dunst/dunstrc" ..
        "i3-battery-popup -n" ..
        "~/.config/wpg/wp_init.sh" ..
        --"~/.config/polybar/launch.sh" ..
        "redshift -l 33.89:151.21" ..
        "dex --autostart --environment awesome" ..
        "sleep 1 && picom -b --config  $HOME/.config/picom/picom.conf" ..
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
       )
-- }}
