require("keyboardInput")

local player = display.newImageRect("arrow.png", 32, 32)
player.x = display.contentCenterX
player.y = display.contentCenterY

local ray = display.newRect(player.x, player.y, 32, 32)
ray.alpha = 0.3

local playerSettings = {
    speed = 16,
    lookSpeed = 10
}

local function checkColision()
    if (player.x < 0) or (player.x > display.contentWidth) or (player.y < 0) or (player.y > display.contentHeight) then
        return true
    end
    return false
end

local function moveObject(speed, object)
    local xD = math.floor(math.sin(math.rad(object.rotation))*speed)
    object.x = object.x + xD
    if checkColision() then
        object.x = object.x - xD
    end
    local yD = math.floor(math.cos(math.rad(object.rotation))*speed)
    object.y = object.y - yD
    if checkColision() then
        object.y = object.y + yD
    end
end

local function strafe(speed, dir)
    if dir == "left" then
        player.rotation = player.rotation - 90
        moveObject(speed, player)
        player.rotation = player.rotation + 90
    elseif dir == "right" then
        player.rotation = player.rotation + 90
        moveObject(speed, player)
        player.rotation = player.rotation - 90
    end
end

local function castRay(x, y, direction)
    
end

local function gameLoop()
    if keys.w or keys.up then
        moveObject(playerSettings.speed, player)
    elseif keys.s or keys.down then
        moveObject(-playerSettings.speed, player)
    end
    if keys.a then
        strafe(playerSettings.speed, "left")
    elseif keys.d then
        strafe (playerSettings.speed, "right")
    end
    if keys.left then
        player.rotation = player.rotation-playerSettings.lookSpeed
    elseif keys.right then
        player.rotation = player.rotation+playerSettings.lookSpeed
    end
end

-- start game loop
gameTimer = timer.performWithDelay(25, gameLoop, 0)