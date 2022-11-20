local awful = require("awful")

return function(table)
    for _, t in ipairs(table) do
        local cmd = t
        if t:find(" ") then
            cmd = t:sub(0, t:find(" ") - 1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", cmd, t));
    end
    awful.spawn("bash -c 'sleep 10 && xset s off -dpms'")
end
