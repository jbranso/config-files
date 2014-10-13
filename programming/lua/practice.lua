#!/usr/bin/lua

a = "hello"
print (a .. " world")

if a == "hello" then
   print("Good")
else
   print("bad")
end

local i = 1
while i < 10 do
   print(i)
end

i = 1
repeat
   i = i + 1
until i == 5
