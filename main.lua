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

local function checkColision(object)
    if (object.x < 0) or (object.x > display.contentWidth) or (object.y < 0) or (object.y > display.contentHeight) then
        return true
    end
    return false
end

local function moveObject(speed, object)
    local xD = math.floor(math.sin(math.rad(object.rotation))*speed)
    object.x = object.x + xD
    if checkColision(object) then
        object.x = object.x - xD
        return true
    end
    local yD = math.floor(math.cos(math.rad(object.rotation))*speed)
    object.y = object.y - yD
    if checkColision(object) then
        object.y = object.y + yD
        return true
    end
    return false
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
    ray.rotation = direction
    ray.x = x
    ray.y = y
    local i = 0
    while (not moveObject(16, ray)) and (i < 200) do
        --display.newRect(ray.x, ray.y, 5, 5)
        i = i + 1
    end
    print("hit")
    return math.sqrt((ray.x-x)*(ray.x-x) + (ray.y-y)*(ray.y-y))
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
    if keys.space then
        castRay(player.x, player.y, player.rotation)
    end
end

-- start game loop
gameTimer = timer.performWithDelay(25, gameLoop, 0)