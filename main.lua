local unitSize = 20


local player = {
    x = 0,
    y = 0,
    rotation = 0
}

local boxSize = 50

local walls = {}
for i = 0, boxSize do
    walls[i] = {}
    for j = 0, boxSize do
        walls[i][j] = 0
    end
end

local function addWall(x, y)
    walls[x][y] = 1
end

local function drawWalls()
    for i = 0, #walls do
        for j = 0, #walls[i] do
            if (walls[i][j]) == 1 then
                display.newRect(i*unitSize, j*unitSize, unitSize, unitSize)
            end
        end
    end
end

for i = 0, boxSize do
    addWall(0, i)
    addWall(i, 0)
    addWall(boxSize, i)
    addWall(i, boxSize)
end

drawWalls()


local function onKeyEvent(event)
    print("key: " .. event.keyName .. " phase: " .. event.phase)
    return false
end

Runtime:addEventListener("key", onKeyEvent)

display.newRect(0, 0, 100, 100)