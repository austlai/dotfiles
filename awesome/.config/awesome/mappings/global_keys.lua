-- Awesome Libs
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local ruled = require("ruled")

local modkey = user_vars.modkey
local altkey = "Mod1"

return gears.table.join(
    awful.key(
        { modkey },
        "s",
        hotkeys_popup.show_help,
        { description = "Key mappings", group = "Awesome" }
    ),
    awful.key(
        { modkey, "Shift" },
        "b",
        function ()
            local s = awful.screen.focused()
            if s.tl and s.tc and s.tr then
                s.tl.visible = not s.tl.visible
                if #s.selected_tag:clients() > 0 and s.tc.visible then
                    s.tc.visible = not s.tc.visible
                end
                s.tc_on = not s.tr.visible
                s.tr.visible = not s.tr.visible
            end
        end,
        {description = "Toggle top wibox.", group = "Awesome"}
    ),
    -- Tag browsing
    awful.key(
        { modkey },
        "Tab",
        awful.tag.history.restore,
        { description = "Go back to last tag", group = "Tag" }
    ),
	awful.key(
		{ modkey },
		"Return",
		function()
			awful.spawn(user_vars.terminal)
		end,
		{ description = "Open terminal", group = "Applications" }
	),
	awful.key(
		{ modkey, "Shift" },
		"r",
		awesome.restart,
		{ description = "Reload awesome", group = "Awesome" }
	),
	awful.key(
		{ altkey, "Shift" },
		"l",
		function()
			awful.tag.incmwfact(0.05)
		end,
		{ description = "Increase client width", group = "Layout" }
	),
	awful.key(
		{ altkey, "Shift" },
		"h",
		function()
			awful.tag.incmwfact(-0.05)
		end,
		{ description = "Decrease client width", group = "Layout" }
	),
	awful.key(
		{ modkey, "Control" },
		"j",
		function()
			awful.tag.incncol(1, nil, true)
		end,
		{ description = "Increase the number of columns", group = "Layout" }
	),
	awful.key(
		{ modkey, "Control" },
		"k",
		function()
			awful.tag.incncol(-1, nil, true)
		end,
		{ description = "Decrease the number of columns", group = "Layout" }
	),
	awful.key(
		{ modkey, "Shift" },
		"space",
		function()
			awful.layout.inc(-1)
		end,
		{ description = "Select previous layout", group = "Layout" }
	),
	awful.key(
		{ modkey },
		"space",
		function()
			awful.layout.inc(1)
		end,
		{ description = "Select next layout", group = "Layout" }
	),
	awful.key(
		{ modkey },
		"d",
		function()
			awful.spawn("rofi -show drun -theme ~/.config/rofi/rofi.rasi")
		end,
		{ descripton = "Application launcher", group = "Application" }
	),
	awful.key(
		{ "Mod1" },
		"tab",
		function()
			awful.spawn("rofi -show window -theme ~/.config/rofi/window.rasi")
		end,
		{ descripton = "Client switcher (alt+tab)", group = "Application" }
	),
	awful.key(
		{ modkey },
		"m",
		function()
			awful.spawn(user_vars.file_manager)
		end,
		{ descripton = "Open file manager", group = "System" }
	),
	awful.key(
		{ modkey, "Shift" },
		"e",
		function()
			awesome.emit_signal("module::powermenu:show")
		end,
		{ descripton = "Session options", group = "System" }
	),
	awful.key(
		{},
		"Print",
		function()
				awful.spawn.with_shell( "sleep 0.2 && maim ~/Pictures/screenshots/$(date +%s).png", false)
		end,
		{ description = "Screenshot", group = "Applications" }
	),
	awful.key(
		{ "Shift" },
		"Print",
		function ()
				awful.spawn.with_shell( "maim -s | xclip -selection clipboard -t image/png", false)
		end,
		{ description = "Screenshot (Select)", group = "Applications" }
		),
	awful.key(
		{},
		"XF86AudioLowerVolume",
		function(c)
				awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%", function()
						awesome.emit_signal("module::slider:update")
				end)
		end,
		{ description = "Lower volume", group = "System" }
	),
	awful.key(
		{},
		"XF86AudioRaiseVolume",
		function(c)
			awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%", function()
				awesome.emit_signal("module::slider:update")
			end)
		end,
		{ description = "Increase volume", group = "System" }
	),
	awful.key(
		{},
		"XF86AudioMute",
		function(c)
			awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
			awesome.emit_signal("module::slider:update")
		end,
		{ description = "Mute volume", group = "System" }
	),
	awful.key(
		{},
		"XF86MonBrightnessUp",
		function(c)
			awful.spawn.with_shell("xbacklight +5")
		end,
		{ description = "Raise backlight brightness", group = "System" }
	),
	awful.key(
		{},
		"XF86MonBrightnessDown",
		function(c)
			awful.spawn.with_shell("xbacklight -5")
		end,
		{ description = "Lower backlight brightness", group = "System" }
	),
    awful.key(
		{ modkey },
		"n",
		function()
			awful.spawn("firefox")
		end,
		{ descripton = "Launch firefox", group = "Application" }
	)
)
