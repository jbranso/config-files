#!/usr/bin/lua

-- this will be the sum variable
sum = 0
number = 0

while number ~= 5000 do
   number = number + 1
   if number % 2 == 0 then
      sum = sum + number
   end
end

print(sum)
