local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

Theme_path = awful.util.getdir("config") .. "/theme/"
Theme = {}

dofile(Theme_path .. "theme_variables.lua")

Theme.awesome_icon = Theme_path .. "../assets/icons/ArchLogo.png"
Theme.awesome_subicon = Theme_path .. "../assets/icons/ArchLogo.png"

-- Wallpaper
beautiful.wallpaper = "/home/austin/Pictures/wallpapers/" .. tostring(math.random(5)) .. ".jpg"
screen.connect_signal(
  'request::wallpaper',
  function(s)
  if beautiful.wallpaper then
    if type(beautiful.wallpaper) == 'string' then
      gears.wallpaper.maximized(beautiful.wallpaper, s)
    else
      beautiful.wallpaper(s)
    end
  end
end
)

beautiful.init(Theme)
