local renders = {}

function renderTexture(quad, texture)
    local w = 720
    local render = display.newImage(texture)
    render.path.x1 = quad.x1
    render.path.x2 = quad.x2
    render.path.x3 = quad.x3
    render.path.x4 = quad.x4
    render.path.y1 = quad.y1
    render.path.y2 = quad.y2
    render.path.y3 = quad.y3
    render.path.y4 = quad.y4
    table.insert(renders, render)
end

function addRender(x, y, r, g, b, a)
    local render = display.newRect(x, y, renderWidth, renderWidth)
    render:setFillColor(r, g, b)
    render.alpha = a
    table.insert(renders, render)
end

function clearRender()
    for i = 1, #renders do
        display.remove(renders[i])
    end
    renders = {}
end