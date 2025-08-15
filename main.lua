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

function checkCollisions(rect1, rect2)
    rect1Left = rect1.x
    rect1Right = rect1.x + rect1.width
    rect1Top = rect1.y
    rect1Bot = rect1.y + rect1.height

    rect2Left = rect2.x
    rect2Right = rect2.x + rect2.width
    rect2Top = rect2.y
    rect2Bot = rect2.y + rect2.height
    

-- Le bloc ci-dessous peut être simplifié pour directement retourner la valeur de la comparaison (cf. plus bas)
    -- if rect1Left < rect2Right
    -- and rect1Right > rect2Left
    -- and rect1Top < rect2Bot
    -- and rect1Bot > rect2Top
    -- then
    --     return true
    -- end
    -- return false

    return rect1Left < rect2Right
    and rect1Right > rect2Left
    and rect1Top < rect2Bot
    and rect1Bot > rect2Top
end

function movePlayer(player, dt)
    if love.keyboard.isDown("left") then
        player.x = player.x - 100 * dt
    end
    if love.keyboard.isDown("right") then
        player.x = player.x + 100 * dt
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - 100 * dt
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + 100 * dt
    end
end

local monRectangle1 = {
    mode = "line",
    x = 100,
    y = 100,
    width = 64,
    height = 128
}

local monRectangle2 = {
    mode = "line",
    x = 200,
    y = 200,
    width = 128,
    height = 64
}

function love.update(dt)
    movePlayer(monRectangle1, dt)
end

function love.keypressed(key, scancode, isinstance)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw() 
    if checkCollisions(monRectangle1, monRectangle2) then
        love.graphics.setColor({1,0,0})
    else
        love.graphics.setColor({0,1,0})
    end
    love.graphics.rectangle(rectUnpack(monRectangle1))
    love.graphics.rectangle(rectUnpack(monRectangle2))
end