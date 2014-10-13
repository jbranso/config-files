#!/usr/bin/lua
-- will all the prime numbers below an inputted number

print ("enter a number: ")
a = io.read("*number")

-- will return true or false, depending in the number is prime
function prime (number)
   count_down = number
   while count_down > 2 do
      count_down = count_down - 1
      if (number % count_down) == 0 then
	 return false
      end
   end
   return true
end

number = 2

print("2")
while number < a do
   number = number + 1
   if prime (number) then
      print (number)
   end
end
