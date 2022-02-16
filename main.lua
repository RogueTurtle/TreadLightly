require("keyboardInput")
require("map")
require("render")

local playerSettings = {
    speed = 4,
    sprintSpeed = 8,
    lookSpeed = 8,
    fov = 60
}

local ratio = 3

local player = {
    x = startPoint.x,
    y = startPoint.y,
    rotation = 0
}

local function moveX(speed, object)
    local xD = math.floor(math.sin(math.rad(object.rotation))*speed)
    object.x = object.x + xD
    if checkColision(object) then
        object.x = object.x - xD
        return true
    end
    object.x = object.x - xD
    return false
end

local function moveY(speed, object)
    local yD = math.floor(math.cos(math.rad(object.rotation))*speed)
    object.y = object.y - yD
    if checkColision(object) then
        object.y = object.y + yD
        return true
    end
    return false
end

local function moveObject(speed, object)
    local xD = math.floor(math.sin(math.rad(object.rotation))*speed)
    object.x = object.x + xD
    if checkColision(object) then
        object.x = object.x - xD
        print("hit  ", object.x, object.y)
        return true
    end
    local yD = math.floor(math.cos(math.rad(object.rotation))*speed)
    object.y = object.y - yD
    if checkColision(object) then
        object.y = object.y + yD
        print("hit  ", object.x, object.y)
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

local function getDistance(object, x, y)
    return math.sqrt((object.x-x)*(object.y-y) + (object.y-y)*(object.y-y))
end

local function drawScene()
    for i, wall in ipairs(walls) do
        local d1 = getDistance(player, wall[1].x, wall[1].y)
        local d2 = getDistance(player, wall[2].x, wall[2].y)

    end
end

local function gameLoop()
    if keys.w or keys.up then
        if keys.leftShift then
            moveObject(playerSettings.sprintSpeed, player)
        else
            moveObject(playerSettings.speed, player)
        end
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
    drawScene()
end

-- start game loop
gameTimer = timer.performWithDelay(25, gameLoop, 0)