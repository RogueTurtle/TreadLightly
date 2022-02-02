keys = {
    w=false,
    a=false,
    s=false,
    d=false,
    up=false,
    down=false,
    left=false,
    right=false,
    space=false
}

-- keyboard event handler
local function keyEvent(event)
    if (event.phase == "down") then
        if (event.keyName == "escape") then
            -- stop the game loop
            timer.cancel(gameTimer)
        elseif (event.keyName == "w") then
            keys.w = true
        elseif (event.keyName == "a") then
            keys.a = true
        elseif (event.keyName == "s") then
            keys.s = true
        elseif (event.keyName == "d") then
            keys.d = true
        elseif (event.keyName == "up") then
            keys.up = true
        elseif (event.keyName == "down") then
            keys.down = true
        elseif (event.keyName == "left") then
            keys.left = true
        elseif (event.keyName == "right") then
            keys.right = true
        elseif (event.keyName == "space") then
            keys.space = true
        end
    else
        if (event.keyName == "w") then
            keys.w = false
        elseif (event.keyName == "a") then
            keys.a = false
        elseif (event.keyName == "s") then
            keys.s = false
        elseif (event.keyName == "d") then
            keys.d = false
        elseif (event.keyName == "up") then
            keys.up = false
        elseif (event.keyName == "down") then
            keys.down = false
        elseif (event.keyName == "left") then
            keys.left = false
        elseif (event.keyName == "right") then
            keys.right = false
        elseif (event.keyName == "space") then
            keys.space = false
        end
    end
end

-- keyboard listener
Runtime:addEventListener("key", keyEvent)