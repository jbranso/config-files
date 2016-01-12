local awful = require("awful")
local beautiful = require("beautiful")

myawesomemenu = {
   { "manual", terminal .. " -e man awesome", configd .. "icons/Faenza/apps/32/bash.png" },
   { "quit awesome", awesome.quit, configd .. "icons/Faenza/actions/32/system-shutdown.png" }
}

libreofficemenu = { { "writer", "libreoffice --writer", configd .. "icons/Faenza/apps/32/libreoffice-main.png"  },
   { "writer", "libreoffice --writer", configd .. "icons/Faenza/apps/32/libreoffice-writer.png"  },
   { "calc", "libreoffice --calc", configd .. "icons/Faenza/apps/32/libreoffice-calc.png"  },
   { "draw", "libreoffice --draw", configd .. "icons/Faenza/apps/32/libreoffice-draw.png"  },
   { "impress", "libreoffice --impress", configd .. "icons/Faenza/apps/32/libreoffice-impress.png"  }}

multimediamenu = {  { "gimp", "gimp", configd .. "icons/Faenza/apps/32/gimp.png" },
   {"vlc", "vlc", configd .. "icons/Faenza/apps/32/vlc.png" },
   {"recordmydesktop", "gtk-recordmydesktop", configd .. "icons/Faenza/apps/32/screenie.png" },
   {"asunder", "asunder", configd .. "icons/Faenza/apps/32/screenie.png" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
			     -- the &edit lets you press e in the menu to launch the edit menu
			     { "libreoffice", libreofficemenu, configd .. "icons/Faenza/apps/32/libreoffice-main.png"},
			     { "multimedia", multimediamenu, configd .. "icons/Faenza/apps/32/audacity.png" },
			     { "&edit config", editor .. " " .. awesome.conffile, "/home/joshua/.config/awesome/icons/Faenza/apps/32/emacs.png" },
			     { "test rc.lua", "~/programming/bash/test_awesome.bash", "/home/joshua/.config/awesome/icons/Faenza/actions/32/system-shutdown.png" },
			     { "restart awesome", awesome.restart, "/home/joshua/.config/awesome/icons/Faenza/actions/32/system-shutdown.png" },
			     { "open terminal",   terminal, "/home/joshua/.config/awesome/icons/Faenza/apps/48/bash.png" },
			     { "&screenshot", "xfce4-screenshooter", "/home/joshua/.config/awesome/icons/Faenza/actions/32/system-shutdown.png" }
}
		       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
