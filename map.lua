startPoint = {x=100,y=100}

vertices = {
    A={x=0,y=0},
    B={x=300,y=0},
    C={x=300,y=200},
    D={x=0,y=200},

    E={x=150,y=20},
    F={x=200,y=20},
    G={x=200,y=70},
    H={x=1507,y=70}
}

walls = {
    {vertices.A,vertices.B},
    {vertices.B,vertices.C},
    {vertices.C,vertices.D},
    {vertices.D,vertices.A},

    {vertices.E,vertices.F},
    {vertices.F,vertices.G},
    {vertices.G,vertices.H},
    {vertices.H,vertices.E},
}

--lines = {}

-- add all walls as lines
for i, wall in ipairs(walls) do
    local slope = ((wall[2].y-wall[1].y)/(wall[2].x-wall[1].x))
    local line = {
        a = slope,
        b = -1,
        c = wall[1].y - slope*wall[1].x
    }
    table.insert(wall, line)
end

---- perpendicular distance from line
local function getDistance(object, line)
    return math.abs(line.a*object.x + line.b*object.y + line.c)/math.sqrt(line.a*line.a + line.b*line.b)
end

function checkColision(object)
    for i, wall in ipairs(walls) do
        if (getDistance(object, wall[3]) < 10) then
            return true
        end
    end
    return false
end