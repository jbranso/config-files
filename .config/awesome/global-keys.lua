local awful = require ('awful')
local naughty = require ('naughty')

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
