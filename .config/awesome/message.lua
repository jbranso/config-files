#!/usr/bin/lua
--local naughty = require("~/programming/awesome/lib/naughty.lua.in")
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
                 })
