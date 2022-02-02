require("keyboardInput")

local player = display.newImageRect("arrow.png", 32, 32)
player.x = display.contentCenterX
player.y = display.contentCenterY

local function movePlayer(speed)
    player.x = player.x + math.floor(math.sin(math.rad(player.rotation))*speed)
    player.y = player.y - math.floor(math.cos(math.rad(player.rotation))*speed)
end

local function strafe(speed, dir)
    if dir == "left" then
        player.rotation = player.rotation - 90
        movePlayer(speed)
        player.rotation = player.rotation + 90
    elseif dir == "right" then
        player.rotation = player.rotation + 90
        movePlayer(speed)
        player.rotation = player.rotation - 90
    end
end

local function gameLoop()
    if keys.w or keys.up then
        movePlayer(16)
    elseif keys.s or keys.down then
        movePlayer(-16)
    end
    if keys.a then
        strafe(16, "left")
    elseif keys.d then
        strafe (16, "right")
    end
    if keys.left then
        player.rotation = player.rotation-5
    elseif keys.right then
        player.rotation = player.rotation+5
    end
end

-- start game loop
gameTimer = timer.performWithDelay(25, gameLoop, 0)