require("keyboardInput")
--require("Loadmap")

local player = display.newImageRect("arrow.png", 32, 32)
player.x = display.contentCenterX
player.y = display.contentCenterY

local function movePlayer(speed)
    player.x = player.x + math.floor(math.sin(math.rad(player.rotation))*speed)
    player.y = player.y - math.floor(math.cos(math.rad(player.rotation))*speed)
end

local function gameLoop()
    if keys.w then
        movePlayer(16)
    elseif keys.s then
        movePlayer(-16)
    end
    if keys.left then
        player.rotation = player.rotation-5
    elseif keys.right then
        player.rotation = player.rotation+5
    end
end

-- start game loop
gameTimer = timer.performWithDelay(25, gameLoop, 0)