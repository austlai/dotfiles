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
  -- TODO: rewrite calendar osd, maybe write an own inplementation
  -- require("modules.calendar_osd")(s)
  require("modules.volume_osd")(s)
  require("modules.brightness_osd")(s)
  require("modules.titlebar")
  require("modules.volume_controller")(s)

  -- Widgets
  --s.battery = require("widgets.battery")()
  s.audio = require("widgets.audio")(s)
  s.date = require("widgets.date")()
  s.clock = require("widgets.clock")()
  --s.bluetooth = require("widgets.bluetooth")()
  s.layoutlist = require("widgets.layout_list")()
  s.powerbutton = require("widgets.power")()
  s.kblayout = require("widgets.kblayout")(s)
  s.taglist = require("widgets.taglist")(s)
  s.tasklist = require("widgets.tasklist")(s)
  --s.cpu_freq = require("widgets.cpu_info")("freq", "average")

  -- Add more of these if statements if you want to change
  -- the modules/widgets per screen.
  if s.index == 1 then
    s.systray = require("widgets.systray")(s)
    s.cpu_usage = require("widgets.cpu_info")("usage")
    s.cpu_temp = require("widgets.cpu_info")("temp")
    s.gpu_usage = require("widgets.gpu_info")("usage")
    s.gpu_temp = require("widgets.gpu_info")("temp")

    require("crylia_bar.left_bar")(s, { s.layoutlist, s.systray, s.taglist })
    require("crylia_bar.center_bar")(s, { s.tasklist })
    require("crylia_bar.right_bar")(s, { s.gpu_usage, s.gpu_temp, s.cpu_usage, s.cpu_temp, s.audio, s.kblayout, s.date, s.clock, s.powerbutton })
    require("crylia_bar.dock")(s, user_vars.dock_programs)
  end

  if s.index == 2 then
    s.network = require("widgets.network")()
    s.ram_info = require("widgets.ram_info")()

    require("crylia_bar.left_bar")(s, { s.layoutlist, s.taglist })
    require("crylia_bar.center_bar")(s, { s.tasklist })
    require("crylia_bar.right_bar")(s, { s.ram_info, s.audio, s.kblayout, s.network, s.date, s.clock, s.powerbutton })
  end
end
)
