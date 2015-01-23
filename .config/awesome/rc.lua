-- Standard awesome library
local vicious = require("vicious")
local bashets = require("bashets")
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- local keydoc = require("keydoc")
require("revelation")
local keydoc = require("keydoc")

--start xcompmgr to enable compositing...will allow terminal shading
awful.util.spawn_with_shell("xcompmgr -cF &")

-- make naughty popups transparent.
-- naughty.config.presets.normal.opacity = 0.9
-- naughty.config.presets.low.opacity = 0.9
-- naughty.config.presets.critical.opacity = 0.9

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
		    title = "Oops, there were errors during startup!",
		    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
			     -- Make sure we don't go into an endless error loop
			     if in_error then return end
			     in_error = true

			     naughty.notify({ preset = naughty.config.presets.critical,
					      title = "Oops, an error happened!",
					      text = err })
			     in_error = false
   end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/joshua/.config/awesome/themes/zenburn/theme.lua")
configd = "/home/joshua/.config/awesome/"
terminal = "lxterminal"
editor = "emacs" -- os.getenv("EDITOR") or
editor_cmd = terminal .. " -e " .. editor

-------------- useful functions
dofile(configd .. "functions.lua")

-- seed and "pop a few"
math.randomseed( os.time())
for i=1,1000 do tmp=math.random(0,1000) end

-- configuration - edit to your liking
wp_index = 1
wp_timeout  = 601
wp_path = "/home/joshua/.config/awesome/pictures/"
wp_files = { "arch_linux1.jpeg", "arch_linux.jpg", "archlinux.png", "dark_tree.jpg", "doctor_who.jpg", "gnu_linux.png",
             "ubuntu.jpeg", "gnu_linux.png", "gnu_linux1.png", "debian.jpg", "linux.png", "tron.jpg", "gods_word.jpeg",
             "god_forgives.jpg", "judah.jpg", "jesus.jpg" }

-- setup the timer
wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", function()

			   -- set wallpaper to current index
			   gears.wallpaper.maximized( wp_path .. wp_files[wp_index] , s, true)

			   -- stop the timer (we don't need multiple instances running at the same time)
			   wp_timer:stop()

			   -- get next random index
			   wp_index = math.random( 1, #wp_files)

			   --restart the timer
			   wp_timer.timeout = wp_timeout
			   wp_timer:start()
end)

-- initial start when rc.lua is first run
wp_timer:start()

dofile (configd .. "speaker.lua")

-- This is used later as the default terminal and editor to run.

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
   {
      awful.layout.suit.max,
      awful.layout.suit.tile,
      awful.layout.suit.tile.bottom,
   }
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
   for s = 1, screen.count() do
      gears.wallpaper.maximized(beautiful.wallpaper, s, true)
   end
end
-- }}}

-- {{{ Tags
-- Define a tag table which will hold all screen tags.
tags = {
   names  = { "        ", "        " },
   layout = { layouts[1], layouts[1]
}}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
dofile (configd .. "menu.lua")

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a memory usage widget I ADDED THIS PART
dofile (configd .. "widgets.lua")

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
	 if c == client.focus then
	    c.minimized = true
	 else
	    -- Without this, the following
	    -- :isvisible() makes no sense
	    c.minimized = false
	    if not c:isvisible() then
	       awful.tag.viewonly(c:tags()[1])
	    end
	    -- This will also un-minimize
	    -- the client, if needed
	    client.focus = c
	    c:raise()
	 end
   end),
   awful.button({ }, 3, function ()
	 if instance then
	    instance:hide()
	    instance = nil
	 else
	    instance = awful.menu.clients({
		  theme = { width = 250 }
	    })
	 end
   end),
   awful.button({ }, 4, function ()
	 awful.client.focus.byidx(1)
	 if client.focus then client.focus:raise() end
   end),
   awful.button({ }, 5, function ()
	 awful.client.focus.byidx(-1)
	 if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
   -- Create a promptbox for each screen
   mypromptbox[s] = awful.widget.prompt()
   -- Create an imagebox widget which will contains an icon indicating which layout we're using.
   -- We need one layoutbox per screen.
   mylayoutbox[s] = awful.widget.layoutbox(s)
   mylayoutbox[s]:buttons(awful.util.table.join(
			     awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
			     awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
			     awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
			     awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
   -- Create a taglist widget
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

   -- Create a tasklist widget
   mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

   -- Create the wibox
   -- I made it taller and wider hopefully?
   mywibox[s] = awful.wibox({ position = "top", height = "48", screen = s })

   -- Widgets that are aligned to the left
   local left_layout = wibox.layout.fixed.horizontal()
   left_layout:add(mylauncher)
   left_layout:add(mytaglist[s])
   left_layout:add(mypromptbox[s])

   -- Widgets that are aligned to the right
   local right_layout = wibox.layout.fixed.horizontal()
   if s == 1 then right_layout:add(wibox.widget.systray()) end
   right_layout:add(firefox_launcher)
   right_layout:add(emacs_launcher)
   right_layout:add(thunderbird_launcher)
   right_layout:add(thunar_launcher)
   right_layout:add(alsamixer_launcher)
   right_layout:add(memwidget)
   right_layout:add(batwidget)
   right_layout:add(mytextclock)
   right_layout:add(mylayoutbox[s])

   -- Now bring it all together (with the tasklist in the middle)
   local layout = wibox.layout.align.horizontal()
   layout:set_left(left_layout)
   layout:set_middle(mytasklist[s])
   layout:set_right(right_layout)

   mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
		awful.button({ }, 3, function () mymainmenu:toggle() end),
		awful.button({ }, 4, awful.tag.viewnext),
		awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
--global keys
--dofile (configd .. "global-keys.lua")
--the following code from global keys is put is global-keys.lua...but if I include the file,
-- and delete the following lines, mod4 + SPC does not work anymore.
globalkeys = awful.util.table.join(

   --So this works, and I have no idea why.
   awful.key({ modkey, }, "o",
      function (c)
	 local curidx = awful.tag.getidx()
	 if curidx == 1 and (client.focus ~= nil) then
	    awful.client.movetotag(tags[client.focus.screen][2])
	 elseif (client.focus ~= nil) then
	    awful.client.movetotag(tags[client.focus.screen][1])
	 end
   end),

   awful.key({ modkey,           }, ".",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

   awful.key({ modkey,           }, "u",
      function ()
	 awful.client.focus.byidx( 1)
	 if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey,           }, "e",
      function ()
	 awful.client.focus.byidx(-1)
	 if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
   awful.key({ modkey, "Control" }, "m", function ()
	 naughty.notify({ timeout = 45, text = "Emacs Commands \n " ..
			     "Registers\n" ..
			     "c r s R               Copy region into register R\n" ..
			     "c r p R               insert text from register R\n" ..
			     "<number> c r n R      put <number> into R\n" ..
			     "c r + R               increase R by one or append text\n"

   }) end),
   awful.key({ modkey,           }, "v", function ()
	 naughty.notify({ timeout = 45, text = "Vim commands \n " ..
			     "<count> <<     shift lines one shiftwidth to the left\n" ..
			     "<count> r      replace <count> chars\n" ..
			     "<count> R      overwrite the rest of the line\n" ..
			     ":[x,y]s/<pat>/<repl>/<f>     substitute (on lines x through y) the\n" ..
			     "pattern <pat> (default the last pattern) with <repl>. Useful flags are\n" ..
			  "g for global (meaning to change every non-overlapping occurrence of <pat>) \n" ..
			  "and c for confirm (it'll prompt you every time it tries to change stuff.)\n" ..
			     "[x,y]t [z]     copy text between x and y to the position after z\n" ..
			     "[x,y]move [z]    move text between x and y to the position after z\n" ..
			  "@#    begin keyboard macro end with @<a-z>. This will store the macro in\n" ..
			  "a register that can be executed later. You can also end it with\n" ..
			     "C-x ) and call that macro with *\n" ..
			     "@<a-z>     execute the contents of a register as a command\n" ..
			     "p     paste\n" ..
			     "cne     copies the next html element\n" ..
			     "cle     copies the last html element\n" ..
			     "cte     copies the current (this) html element\n" ..
			     "gg      go to line numeber\n" ..
			     "gc      go to char\n" ..
                             "gf      find file at point\n" ..
			     "SPC     go to work\n" ..
			     "mnt     mark next like this\n" ..
			     "mpt     mark previous like this\n" ..
			     "p.      expand region, which marks a section of text\n" ..
			     "p,      extract a region of text\n" ..
			     "gc      go to char\n" ..
			     "gs      go to a forward word\n"
   }) end),
   -- {{ Volume Control }} --
   awful.key({ }, "XF86AudioRaiseVolume", function()
	 -- don't let the user raise the volume over a certian threshhold
	 -- If they use the keyboard keys, the volume won't ever get over 94%,
	 -- but if they use alsamixer, it can go over 94%. This makes sure that even if
	 --if the user sets the volume over 94% using alsamixer, the volume will be
	 -- changed back to 94% when they next press the button to increase the volume
	 if percent >= 95 then  --if the volume is too loud, lower it
	    percent = 94
	    awful.util.spawn("amixer set Master 94%", false)
	    awful.util.spawn("amixer set Headphone 94%", false)
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-high.png" )
	    return
	    --if the volume is at the max limit, don't do anything
	    -- This elseif should not have to change the volume image. If percent == 94, then
	    -- then one should not have to do anything.
	 elseif percent == 94 then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-high.png" )
	    return
	    --if the volume is just below the max, increase volume to the max level
	 elseif (percent >= 90) and ( percent <= 93) then
	    percent = 94
	    awful.util.spawn("amixer set Master 94%", false)
	    awful.util.spawn("amixer set Headphone 94%", false)
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-high.png" )
	    return
	 end

	 --if the volume % is from 0 - 89, change volume the normal way
	 awful.util.spawn("amixer set Master "    .. tostring ((tonumber (percent) + 5)) .. "%", false)
	 awful.util.spawn("amixer set Headphone " .. tostring ((tonumber (percent) + 5)) .. "%", false)
	 percent = percent + 5
	 if volume == "off" then
	    -- do not update the icon
	 elseif (percent <= 30) then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-off.png" )
	 elseif (percent >= 31) and (percent <= 61) then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-low.png" )
	 elseif (percent >= 62) and (percent <= 93) then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-medium.png" )
	 end
   end),
   awful.key({ }, "XF86AudioLowerVolume", function()
      	 if volume == "off" then
	    -- do not update the icon
	    return
	 elseif percent == 0 then
	    --do nothing
	    return
	 elseif (percent <= 5) and (percent > 0) then
	    awful.util.spawn("amixer set Master 0%")
	    awful.util.spawn("amixer set Headphone 0%")
	    return
	 end

	 awful.util.spawn("amixer set Master "    .. tostring ((tonumber (percent) - 5)) .. "%", false)
	 awful.util.spawn("amixer set Headphone " .. tostring ((tonumber (percent) - 5)) .. "%", false)
	 percent = percent - 5
	 -- update the image the normal way
	 if percent <= 30 then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-off.png" )
	 elseif (percent >= 31) and (percent <= 61) then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-low.png" )
	 elseif (percent >= 62) and (percent <= 93) then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-medium.png" )
	 elseif percent == 94 then
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-high.png" )
	 end
   end),

   -- CHECK THIS OUT... amixer get "Master"  will tell you the state of master
   awful.key({ }, "XF86AudioMute", function()
	 --toggle the speakers with amixer. Alsamixer works really weirdly. The command to turn off master
	 if volume == "on" then
	    awful.util.spawn("amixer set 'Master' toggle", false)
	    awful.util.spawn("amixer set 'Headphone' toggle", false)
	    --update the image
	    alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-muted-blocked-panel.png" )
	    volume = "off"
	 else
	    awful.util.spawn("amixer set 'Master' toggle" , false)
	    awful.util.spawn("amixer set 'Speaker' toggle" , false)
	    awful.util.spawn("amixer set 'Headphone' toggle" , false)
	    awful.util.spawn("amixer set 'Bass Speaker' toggle" , false)
	    volume = "on"
	    --update the image
	    if (percent <= 30) then
	       alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-off.png" )
	    elseif (percent >= 31) and (percent < 61) then
	       alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-low.png" )
	    elseif (percent >= 62) and (percent < 92) then
	       alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-medium.png" )
	    else  -- p >= 88
	       alsamixer_launcher:set_image ( configd .. "icons/Faenza/status/48/audio-volume-high.png" )
	    end
	 end
   end),
   awful.key({ }, "XF86Eject", function() awful.util.spawn("eject", false)
	 naughty.notify({ icon = configd .. "icons/Faenza/actions/48/media-eject.png" }) end),

   -- {{ light control }} --
   awful.key({ }, "XF86MonBrightnessUp", function() awful.util.spawn("light -aq 20", false) end),
   awful.key({ }, "XF86MonBrightnessDown", function() awful.util.spawn("light -sq 20", false) end),

   -- change layout to dvorak. This is only for running awesome in a nested X session. When I run awesome in a nested
   -- x session, it automatically start it in qwerty layout.
   awful.key({ modkey, "Control" }, "q", function () awful.util.spawn("~/programming/bash/test_awesome.bash", false) end),

   -- revelation it makes all the windows small down so I can see all of them --
   awful.key({ }, "XF86LaunchA", revelation),

   keydoc.group ("Layout Manipulation"),
   -- minimize all clients. It will stand for clear screen... Now I need to make it open all clients when I click it again.
   awful.key({ modkey,           }, "c",
      function ()
	 client_table = client.get()
	 -- if one client is not minimized, then minimize all clients
	 local all_clients_are_minimized
	 for number, value_in_table in ipairs (client_table) do
	    if client_table[number].minimized == false then
	       all_clients_are_minimized = false
	    end
	 end
	 if all_clients_are_minimized == false then --if some clients are open, minimize them
	    for number, value_in_table in ipairs (client_table) do
	       client_table[number].minimized = true
	    end
	 else --if all clients are minimized, restore them   NOT WORKING
	    for number, value_in_table in ipairs (client_table) do
	       client_table[number].minimized = false
	    end
	 end
      end,
      "toggle visibility of the screen"),

   -- Layout manipulation
   keydoc.group("Navigation"),
   awful.key({ modkey, "Shift"   }, "e", function () awful.client.swap.byidx(  1)    end,
      "Switch to the left client"),
   awful.key({ modkey, "Shift"   }, "u", function () awful.client.swap.byidx( -1)    end,
      "Switch to the right client"),
   awful.key({ modkey,           }, "Tab",
      function ()
	 awful.client.focus.history.previous()
	 if client.focus then
	    client.focus:raise()
	 end
      end,
      "Switch to next client"),

   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end,
      "spawn terminal"),
   awful.key({ modkey, "Control" }, "r", awesome.restart,
      "restart awesome"),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit,
      "quit awesome"),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end,
      "increase the client size"),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end,
      "decrease the client size"),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end,
      "change the current layout"),

   awful.key({ modkey, "Control" }, "n", function ()
	 awful.client.restore ()
	 -- raise the restored client
	 current_client = awful.client.next (-1)
	 current_client:raise ()
					 end,
      "raise and focus a minimized client"),



   -- Prompt
   -- this binding conflicts with the binding that decreases width.
   -- awful.key({ modkey           },            "l",     function () mypromptbox[mouse.screen]:run() end),

   awful.key({ modkey           }, "x",
      function ()
	 awful.prompt.run({ prompt = "Run Lua code: " },
	    mypromptbox[mouse.screen].widget,
	    awful.util.eval, nil,
	    awful.util.getdir("cache") .. "/history_eval")
   end),
   -- Menubar
   awful.key({ modkey }, "r", function() menubar.show() end,
      "show the menu bar")
)

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Control" }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
   awful.key({ modkey,           }, "n",
      function (c)
	 -- The client currently has the input focus, so it cannot be
	 -- minimized, since minimized clients can't have the focus.
	 -- add a check here.
	 -- if c.w_class == "Emacs" then
	 -- c.w_class = "desktop_emacs"
	 -- elseif c.w_class == "desktop_emacs" then
	 -- don't do anything.
	 -- else
	 -- c.minimized = true
	 -- end
	 --
	 c.minimized = true
   end),
   awful.key({ modkey,           }, "m",
      function (c)
	 c.maximized_horizontal = not c.maximized_horizontal
	 c.maximized_vertical   = not c.maximized_vertical
   end),

   awful.key({ modkey, "Control" }, "d", keydoc.display)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = awful.util.table.join(globalkeys,
				      -- View tag only.
				      awful.key({ modkey }, "#" .. i + 9,
					 function ()
					    local screen = mouse.screen
					    local tag = awful.tag.gettags(screen)[i]
					    if tag then
					       awful.tag.viewonly(tag)
					    end
				      end),
				      -- Toggle tag.
				      awful.key({ modkey, "Control" }, "#" .. i + 9,
					 function ()
					    local screen = mouse.screen
					    local tag = awful.tag.gettags(screen)[i]
					    if tag then
					       awful.tag.viewtoggle(tag)
					    end
				      end),
				      -- Move client to tag.
				      awful.key({ modkey, "Shift" }, "#" .. i + 9,
					 function ()
					    if client.focus then
					       local tag = awful.tag.gettags(client.focus.screen)[i]
					       if tag then
						  awful.client.movetotag(tag)
					       end
					    end
				      end),
				      -- Toggle tag.
				      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
					 function ()
					    if client.focus then
					       local tag = awful.tag.gettags(client.focus.screen)[i]
					       if tag then
						  awful.client.toggletag(tag)
					       end
					    end
   end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

local ror = require("aweror")
-- generate and add the 'run or raise' key bindings to the globalkeys table
globalkeys = awful.util.table.join(globalkeys, ror.genkeys(modkey))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
		    border_color = beautiful.border_normal,
		    focus = awful.client.focus.filter,
		    raise = true,
		    keys = clientkeys,
		    buttons = clientbuttons } },
   { rule = { class = "Lxterminal" },
     properties = {
	opacity = 0.9,
     },
   },
   { rule = { class = "workrave" },
     properties = {
	hidden = true,
	opacity = 0,
	below = true,
     },
   },
   { rule = { class = "Emacs" },
     properties = {
	opacity = 0.95
     },
     { rule = { class = "gimp" },
       properties = { floating = true } },
     -- Set Firefox to always map on tags number 2 of screen 1.
     -- { rule = { class = "Firefox" },
     --   properties = { tag = tags[1][2] } },
}}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
			 -- Enable sloppy focus
			 c:connect_signal("mouse::enter", function(c)
					     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
					     and awful.client.focus.filter(c) then
						client.focus = c
					     end
			 end)

			 if not startup then
			    -- Set the windows at the slave,
			    -- i.e. put it at the end of others instead of setting it master.
			    -- awful.client.setslave(c)

			    -- Put windows in a smart way, only if they does not set an initial position.
			    if not c.size_hints.user_position and not c.size_hints.program_position then
			       awful.placement.no_overlap(c)
			       awful.placement.no_offscreen(c)
			    end
			 end

			 local titlebars_enabled = false
			 if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
			    -- buttons for the titlebar
			    local buttons = awful.util.table.join(
			       awful.button({ }, 1, function()
				     client.focus = c
				     c:raise()
				     awful.mouse.client.move(c)
			       end),
			       awful.button({ }, 3, function()
				     client.focus = c
				     c:raise()
				     awful.mouse.client.resize(c)
			       end)
			    )

			    -- Widgets that are aligned to the left
			    local left_layout = wibox.layout.fixed.horizontal()
			    left_layout:add(awful.titlebar.widget.iconwidget(c))
			    left_layout:buttons(buttons)

			    -- Widgets that are aligned to the right
			    local right_layout = wibox.layout.fixed.horizontal()
			    right_layout:add(awful.titlebar.widget.floatingbutton(c))
			    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
			    right_layout:add(awful.titlebar.widget.stickybutton(c))
			    right_layout:add(awful.titlebar.widget.ontopbutton(c))
			    right_layout:add(awful.titlebar.widget.closebutton(c))

			    -- The title goes in the middle
			    local middle_layout = wibox.layout.flex.horizontal()
			    local title = awful.titlebar.widget.titlewidget(c)
			    title:set_align("center")
			    middle_layout:add(title)
			    middle_layout:buttons(buttons)

			    -- Now bring it all together
			    local layout = wibox.layout.align.horizontal()
			    layout:set_left(left_layout)
			    layout:set_right(right_layout)
			    layout:set_middle(middle_layout)

			    awful.titlebar(c):set_widget(layout)
			 end
end)

client.connect_signal("focus", function(c)
			 -- if the focused client is not maximized, do not color the border.
			 if (c.maximized == false) then
			    c.border_color = beautiful.border_focus
			    -- why does this not work?			 -- else
			    --    c.border_color = beautful.border_normal
			 end

end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- awful.util.spawn_with_shell("firefox")
-- awful.util.spawn_with_shell("xfce4-panel --disable-wm-check")
run_once("firefox-nightly -P nightly")
run_once("workrave")
--run_once("thunar")
awful.util.spawn("xcalib /home/joshua/colorprofile/color.icc")
-- the --sm-disable & lets the nm-applet menu work nicely.
awful.util.spawn_with_shell("run_once nm-applet --sm-disable &")
-- this next line was for getting network-manager working. I probably don't need it.
-- awful.util.spawn("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
-- run_once("xfce4-panel --disable-wm-check")
