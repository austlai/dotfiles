-- Awesome Libs
local awful = require("awful")
local gears = require("gears")

local modkey = user_vars.modkey

return gears.table.join(
    awful.key(
        { modkey },
        "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "Toggle fullscreen", group = "Client" }
    ),
    awful.key(
        { modkey },
        "q",
        function(c)
            c:kill()
        end,
        { description = "Close focused client", group = "Client" }
    ),
    awful.key(
        { modkey, "Shift" },
        "space",
        awful.client.floating.toggle,
        { description = "Toggle floating window", group = "Client" }
    ),
    awful.key(
        { modkey, "Control" },
        "Return",
        function (c)
            c:swap(awful.client.getmaster())
        end,
        {description = "Move to master", group = "Client"}
    ),
    awful.key(
        { modkey },
        "t",
        function (c)
            c.ontop = not c.ontop
        end,
        {description = "Toggle keep on top", group = "Client"}),
    awful.key(
        { modkey },
        "Down",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "Minimize", group = "Client"}),
    awful.key({ modkey }, "Up",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "Maximize", group = "Client"}
    )
)