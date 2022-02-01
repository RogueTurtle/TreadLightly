composer = require("composer")
local scene = composer.newScene()


local unitSize = 10


local player = {
    x = 0,
    y = 0,
    rotation = 0
}

local walls = {}
for i = 0, 9 do
    walls[i] = {}
    for j = 0, 9 do
        walls[i][j] = 0
    end
end

local function addWall(x, y)
    walls[x][y] = 1
end

local function drawWalls()
    for i = 0, walls.length do
        for j = 0, walls[i].length do
            if (walls[i][j]) == 1 then
                display.newRect(i*unitSize, j*unitSize, unitSize, unitSize)
            end
        end
    end
end

for i = 0, 9 do
    addWall(0, i)
    addWall(i, 0)
    addWall(9, i)
    addWall(i, 9)
end