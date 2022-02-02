-- Loading map file and checking for collisions

function CheckCollision(x,y)
    if 1 == 1 then
        print("Fuck Lua")
    end
    local colCheck = false
    return colCheck
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local f = io.open("Map.txt", "r")
local parsedMap = Split(f:read("*a"), ":")
io.close()

Map = {}          -- create the matrix
    for i=1,10 do
    Map[i] = {}
        for j=1,10 do
            local furtherSplit = Split(parsedMap[i], ",")
            Map[i][j] = furtherSplit[j]
        end
    end
