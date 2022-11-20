--------------------------------------------------------------------------------------------------------------
-- This is the statusbar, every widget, module and so on is combined to all the stuff you see on the screen --
--------------------------------------------------------------------------------------------------------------
-- Awesome Libs
local awful = require("awful")

awful.screen.connect_for_each_screen(
-- For each screen this function is called once
-- If you want to change the modules per screen use the indices
-- e.g. 1 would be the primary screen and 2 the secondary screen.
    function(s)
    -- Create 9 tags
    awful.layout.layouts = user_vars.layouts
    awful.tag(
        { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
        s,
        user_vars.layouts[1]
    )

    require("modules.powermenu")(s)
    require("modules.titlebar")
    require("modules.volume_controller")(s)

    -- Widgets
    s.battery = require("widgets.battery")()
    s.audio = require("widgets.audio")(s)
    s.date = require("widgets.date")()
    s.clock = require("widgets.clock")()
    --s.bluetooth = require("widgets.bluetooth")()
    s.layoutlist = require("widgets.layout_list")()
    s.powerbutton = require("widgets.power")()
    s.taglist = require("widgets.taglist")(s)
    s.tasklist = require("widgets.tasklist")(s)
    s.systray = require("widgets.systray")(s)
    s.cpu_usage = require("widgets.cpu_info")("usage")
    s.gpu_usage = require("widgets.gpu_info")("usage")
    --s.network = require("widgets.network")()
    s.ram_info = require("widgets.ram_info")()

    s.l_bar = require("crylia_bar.left_bar")(s, { s.layoutlist, s.systray, s.taglist })
    s.c_bar = require("crylia_bar.center_bar")(s, { s.tasklist })
    s.r_bar = require("crylia_bar.right_bar")(s, { s.ram_info, s.cpu_usage, s.audio, s.battery, s.date, s.clock, s.powerbutton })

end
)
