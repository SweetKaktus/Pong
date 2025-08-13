local Rectangle = require("Rectangle")

-- Cette fonction me permet de dépiler mes rectangles pour pouvoir les afficher dans la fonction love.graphics.rectangle
-- usage : love.graphics.rectangle(rectUnpack(monRectangle))
function rectUnpack(rectangle)
    order = {"mode", "x", "y", "width", "height"}
    args = {}
    for _, key in ipairs(order) do
        table.insert(args, rectangle[key])
    end
    return unpack(args)
end

local lilKaktus = love.graphics.newImage("kaktus.png")

local player = {spr = lilKaktus, x = 100, y = 100, sx = .2, sy = .2}

function love.update(dt)
    if love.keyboard.isDown("right") then
        player.x = player.x + 100 * dt
        player.sx = player.sx + .1 * dt
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - 100 * dt
        player.sx = player.sx - .1 * dt
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - 100 * dt
        player.sy = player.sy + .1 * dt
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + 100 * dt
        player.sy = player.sy - .1 * dt
    end
end

function love.draw()
    love.graphics.draw(player.spr, player.x, player.y, 0, player.sx, player.sy)
end