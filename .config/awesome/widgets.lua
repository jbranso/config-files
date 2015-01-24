local awful = require ('awful')
local vicious = require ('vicious')
local wibox = require ('wibox')
local naughty = require ('naughty')

-- Create the battery-box widget This is the green box you see in the upper right.
batwidget = awful.widget.progressbar()
batwidget:set_width(40)
batwidget:set_height(10)
batwidget:set_vertical(true)
batwidget:set_background_color("#494B4F")
batwidget:set_border_color(nil)
batwidget:set_color("#AECF96")
-- batwidget:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
-- it is always a good idea to use prime numbers when registering widgets. The chances of 2 things
-- happening on the same second are more unlikely
isBatLessThan5 = "no"
vicious.register(batwidget, vicious.widgets.bat,
		 function (widget, args)
		    if isBatLessThan5 == "yes" then
		       widget:set_color(gradient(0, 100, tonumber(args[2])))
		       return args[2]
		    elseif args[2] < 5 then
		       naughty.notify({
			     timeout = 45, text = "Your battery is getting low \n" ..
				"You should probably plug in your charger. This is your last warning."
		       })
		       isBatLessThan5 = "yes"
		       widget:set_color(gradient(0, 100, tonumber(args[2])))
		       return args[2]
		    else
		       widget:set_color(gradient(0, 100, tonumber(args[2])))
		       return args[2]
		    end
		 end,
		 127, "BAT0")

-- Create a memory usage widget I ADDED THIS PART
memwidget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, " mem $1%", 13)

-- create some launchers to add to the wibox...
thunar_launcher      = awful.widget.launcher({ image = configd .. "icons/Faenza/actions/48/stock_home.png",
					       command = "thunar" })
