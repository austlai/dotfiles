-- Set shell since default is fish
local awful = require("awful")
awful.util.shell = "bash"

require("theme.user_variables")
require("theme.init")
require("core.error_handling")
require("core.signals")
require("core.notifications")
require("core.rules")
require("mappings.global_buttons")
require("mappings.bind_to_tags")
require("crylia_bar.init")
require("tools.auto_starter")(user_vars.autostart)

local gears = require("gears")
gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
}
