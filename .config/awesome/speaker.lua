local awful = require ('awful')
--let's get the percent that the speakers are on
-- this code only works because amixer outputs whole numbers for percents

--let's find out if the speakers are on
if os.execute("amixer get Master | grep '\\[on\\]'") then
   volume = "on"
else
   volume = "off"
end

percent = os.capture ("amixer get Master | grep % | gawk '{ print $4 }' ", raw)
if string.len(percent) == 4 then
   percent = 0
elseif string.len(percent) == 5 then
   percent = tonumber (string.sub (percent, 2, 3))
else
   percent = 100
end


if (percent <= 30) then
   alsamixer_launcher   = awful.widget.launcher({ image = configd .. "icons/Faenza/status/48/audio-volume-off.png",
						  command = awful.util.spawn_with_shell(terminal .. " alsamixer") })
elseif (percent >= 31) and (percent < 61) then
   alsamixer_launcher   = awful.widget.launcher({ image = configd .. "icons/Faenza/status/48/audio-volume-low.png",
						  command = awful.util.spawn_with_shell(terminal .. " alsamixer") })
elseif (percent >= 62) and (percent < 92) then
   alsamixer_launcher   = awful.widget.launcher({ image = configd .. "icons/Faenza/status/48/audio-volume-medium.png",
						  command = awful.util.spawn_with_shell(terminal .. " alsamixer") })
else  -- p >= 88
   alsamixer_launcher   = awful.widget.launcher({ image = configd .. "icons/Faenza/status/48/audio-volume-high.png",
						  command = awful.util.spawn_with_shell(terminal .. " alsamixer") })
end
