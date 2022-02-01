-- Loading map file and checking for collisions

function CheckCollision(x,y)
    if 1 == 1 then
        print("Fuck Lua")
    end
    local colCheck = false
    return colCheck
end

local f = io.open("Map.txt", "r")
print(f:read("*a"))
print("hi")
--TODO create array with parsed data from map file and append it to the 2d array with layering
local mt = {}          -- create the matrix
    for i=1,10 do
      mt[i] = {}     -- create a new row
      for j=1,10 do
        mt[i][j] = 0
      end
    end
