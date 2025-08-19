local Player = require("Player")
local Ball = require("Ball")
local Rectangle = require("Rectangle")
local Config = require("Config")

function love.load()
    math.randomseed(os.time())
    -- Définir taille écran
    love.window.setMode( 800, 600 )
    local randX = 0
    local randY = 0
    if math.random(0,1) == 0 then
        randX = -1
    else
        randX = 1
    end
    if math.random(0,1) == 0 then
        randY = 0.5
    else
        randY = -0.5
    end
    -- Charger les joueurs
    player1 = Player:new(300, 200, {x=0,y=0}, {x=30,y=250}, {width=16,height=64}, "1")
    player2 = Player:new(300, 200, {x=0,y=0}, {x=800-46,y=250}, {width=16,height=64}, "2")
    ball = Ball:new(200, 200, {x=randX,y=randY}, {x=392.5,y=275}, {width=16,height=16})
    leftGroundRect = Rectangle:new("line", 5, 5, 395, 590)
    rightGroundRect = Rectangle:new("line", 400, 5, 395, 590)
end


local boundaries = {
    top = Rectangle:new("line", -5, -5, 1000, 11),
    bot = Rectangle:new("line", -5, 594, 1000, 11),
    left = Rectangle:new("line", -5, -5, 11, 700),
    right = Rectangle:new("line", 795, -5, 11, 700),
    
}

function love.keypressed(key, scancode, isinstance)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    player1:setDirectionBasedOnPlayerNumber()
    player2:setDirectionBasedOnPlayerNumber()
    player1:move(dt)
    player2:move(dt)
    player1.shape.x = player1.position.x
    player1.shape.y = player1.position.y
    player2.shape.x = player2.position.x
    player2.shape.y = player2.position.y
    
    ball:move(dt)
    ball.shape.x = ball.position.x
    ball.shape.y = ball.position.y
    ball:changeDirection(player1.shape)
    ball:changeDirection(player2.shape)
    ball:changeDirection(boundaries.top)
    ball:changeDirection(boundaries.bot)
end

function love.draw()
    love.graphics.rectangle(player1.shape:rectUnpack())
    love.graphics.rectangle(player2.shape:rectUnpack())
    love.graphics.rectangle(ball.shape:rectUnpack())
    love.graphics.rectangle(leftGroundRect:rectUnpack())
    love.graphics.rectangle(rightGroundRect:rectUnpack())
end