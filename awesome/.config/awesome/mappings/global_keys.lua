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
    --[[ TODO: FIX THIS I WANT IT
    awful.key(
        { modkey, "Shift" }, 
        "b", 
        function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "Toggle top wibox.", group = "Awesome"}
    ),
    --]]
    -- Tag browsing
    awful.key(
        { modkey },
        "Tab",
        awful.tag.history.restore,
        { description = "Go back to last tag", group = "Tag" }
    ),
	awful.key(
		{ modkey },
		"Enter",
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
				awful.util.spawn( "maim ~/Pictures/screenshots/$(date +%s).png" )
		end,
		{ description = "Screenshot", group = "Applications" }
	),
	awful.key(
		{ "Shift" }, 
		"Print", 
		function () 
				awful.util.spawn( "maim -s | xclip -selection clipboard -t image/png" ) 
		end,
		{ description = "Screenshot (Select)", group = "Applications" }
		),
	awful.key(
		{},
		"XF86AudioLowerVolume",
		function(c)
				awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ -2%", function()
						awesome.emit_signal("module::volume_osd:show", true)
						awesome.emit_signal("module::slider:update")
						awesome.emit_signal("widget::volume_osd:rerun")
				end)
		end,
		{ description = "Lower volume", group = "System" }
	),
	awful.key(
		{},
		"XF86AudioRaiseVolume",
		function(c)
			awful.spawn.easy_async_with_shell("pactl set-sink-volume @DEFAULT_SINK@ +2%", function()
				awesome.emit_signal("module::volume_osd:show", true)
				awesome.emit_signal("module::slider:update")
				awesome.emit_signal("widget::volume_osd:rerun")
			end)
		end,
		{ description = "Increase volume", group = "System" }
	),
	awful.key(
		{},
		"XF86AudioMute",
		function(c)
			awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
			awesome.emit_signal("module::volume_osd:show", true)
			awesome.emit_signal("module::slider:update")
			awesome.emit_signal("widget::volume_osd:rerun")
		end,
		{ description = "Mute volume", group = "System" }
	),
	awful.key(
		{},
		"XF86MonBrightnessUp",
		function(c)
			--awful.spawn("xbacklight -time 100 -inc 10%+")
			awful.spawn.easy_async_with_shell(
				"pkexec xfpm-power-backlight-helper --get-brightness",
				function(stdout)
					awful.spawn.easy_async_with_shell("pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(tonumber(stdout) + BACKLIGHT_SEPS), function(stdou2)

					end)
					awesome.emit_signal("module::brightness_osd:show", true)
					awesome.emit_signal("module::brightness_slider:update")
					awesome.emit_signal("widget::brightness_osd:rerun")
				end
			)
		end,
		{ description = "Raise backlight brightness", group = "System" }
	),
	awful.key(
		{},
		"XF86MonBrightnessDown",
		function(c)
			awful.spawn.easy_async_with_shell(
				"pkexec xfpm-power-backlight-helper --get-brightness",
				function(stdout)
					awful.spawn.easy_async_with_shell("pkexec xfpm-power-backlight-helper --set-brightness " .. tostring(tonumber(stdout) - BACKLIGHT_SEPS), function(stdout2)

					end)
					awesome.emit_signal("module::brightness_osd:show", true)
					awesome.emit_signal("module::brightness_slider:update")
					awesome.emit_signal("widget::brightness_osd:rerun")
				end
			)
		end,
		{ description = "Lower backlight brightness", group = "System" }
	),
	awful.key(
		{ modkey },
		"#22",
		function()
			awful.spawn.easy_async_with_shell(
				[[xprop | grep WM_CLASS | awk '{gsub(/"/, "", $4); print $4}']],
				function(stdout)
					if stdout then
						ruled.client.append_rule {
							rule = { class = stdout:gsub("\n", "") },
							properties = {
								floating = true
							},
						}
						awful.spawn.easy_async_with_shell(
							"cat ~/.config/awesome/assets/rules.txt",
							function(stdout2)
								for class in stdout2:gmatch("%a+") do
									if class:match(stdout:gsub("\n", "")) then
										return
									end
								end
								awful.spawn.with_shell("echo -n '" .. stdout:gsub("\n", "") .. ";' >> ~/.config/awesome/assets/rules.txt")
								local c = mouse.screen.selected_tag:clients()
								for j, client in ipairs(c) do
									if client.class:match(stdout:gsub("\n", "")) then
										client.floating = true
									end
								end
							end
						)
					end
				end
			)
		end
	),
	awful.key(
		{ modkey, "Shift" },
		"#22",
		function()
			awful.spawn.easy_async_with_shell(
				[[xprop | grep WM_CLASS | awk '{gsub(/"/, "", $4); print $4}']],
				function(stdout)
					if stdout then
						ruled.client.append_rule {
							rule = { class = stdout:gsub("\n", "") },
							properties = {
								floating = false
							},
						}
						awful.spawn.easy_async_with_shell(
							[[REMOVE="]] .. stdout:gsub("\n", "") .. 
                            [[;"STR=$(cat ~/.config/awesome/assets/rules.txt)
								echo -n ${STR//$REMOVE/} > ~/.config/awesome/assets/rules.txt
							]],
							function(stdout2)
								local c = mouse.screen.selected_tag:clients()
								for j, client in ipairs(c) do
									if client.class:match(stdout:gsub("\n", "")) then
										client.floating = false
									end
								end
							end
						)
					end
				end
			)
		end
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
