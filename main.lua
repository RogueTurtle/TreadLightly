require("keyboardInput")
require("map")

local playerSettings = {
    speed = 4,
    sprintSpeed = 8,
    lookSpeed = 8,
    fov = 60
}

local player = {
    x = display.contentCenterX,
    y = display.contentCenterY,
    rotation = 0
}

local renders = {}

local function addRender(x, y, r, g, b, a)
    local render = display.newRect(x, y, renderWidth, renderWidth)
    render:setFillColor(r, g, b)
    render.alpha = a
    table.insert(renders, render)
end

local function clearRender()
    for i = 1, #renders do
        display.remove(renders[i])
    end
    renders = {}
end

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
    --if keys.space then
    --   castRay(player.x, player.y, player.rotation)
    --end
    drawScene()
end

-- start game loop
gameTimer = timer.performWithDelay(25, gameLoop, 0)