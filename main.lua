require("keyboardInput")

local renderWidth = 4

--local player = display.newImageRect("arrow.png", 32, 32)
--player.x = display.contentCenterX
--player.y = display.contentCenterY

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

local ray = {
    x = display.contentCenterX,
    y = display.contentCenterY,
    rotation = 0
}

local function checkColision(object)
    if (object.x < 0) or (object.x > display.contentWidth) or (object.y < 0) or (object.y > display.contentHeight) then
        return true
    end
    return false
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

local function castRay(x, y, direction)
    ray.rotation = direction
    ray.x = x
    ray.y = y
    local i = 0
    while (not moveObject(16, ray)) and (i < 200) do
        i = i + 1
    end
    return math.sqrt((ray.x-x)*(ray.x-x) + (ray.y-y)*(ray.y-y))
end

local function drawScene()
    clearRender()
    local lines = 1280/renderWidth
    local x = 0
    local dir = player.rotation-playerSettings.fov/2
    local dist = 0
    for i=0,lines do
        dist = castRay(player.x, player.y, dir)
        if dist == 0 then
            dist = 1
        end
        local height = 8000/dist
        dir = dir + playerSettings.fov/lines
        x = x + renderWidth
        local c = 0
        if moveX(16, ray) then
            c = 1
        end
        local brightness = (1/(dist/1))*70
        print(brightness)
        for j=display.contentCenterY-height, display.contentCenterY+height, renderWidth do
            if c == 0 then
                addRender(x, j, 255, 0, 0, brightness)
            else
                addRender(x, j, 0, 0, 255, brightness)
            end
        end
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