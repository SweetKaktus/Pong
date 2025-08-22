local Player = require("Player")
local Ball = require("Ball")
local Rectangle = require("Rectangle")
local Config = require("Config")
local UI = require("UI")
local Audio = require("Audio")

local initBallPosX = 392.5
local initBallPosY = 275
local initBallDirX = 0
local initBallDirY = 0
local initTime = os.time()

local randX = 0
local randY = 0

local player1ScoreText = "Player 1 : "
local player2ScoreText = "Player 2 : "
local scoreToWin = 5

function printScore()
    love.graphics.setNewFont("Anta-Regular.ttf", 22)
    love.graphics.print(player1ScoreText..player1.score, UI.player1ScorePosition.x, UI.player1ScorePosition.y)
    love.graphics.print(player2ScoreText..player2.score, UI.player2ScorePosition.x, UI.player2ScorePosition.y)
end

function printWin(player)
    love.graphics.setNewFont("Anta-Regular.ttf", 32)
    love.graphics.setColor({0,0,0})
    local tempRect = Rectangle:new("fill", Config.screenWidth / 2 - 110, Config.screenHeight / 2 - 126, 128, 37)
    love.graphics.rectangle(tempRect:rectUnpack())
    love.graphics.setColor({1,1,1})
    love.graphics.print({{1,1,0}, "Player "..player.playerNumber.." Wins !"}, Config.screenWidth / 2 - 110, Config.screenHeight / 2 - 128)
end

function resetBallPosition()
    ball.dir.x = initBallDirX
    ball.dir.y = initBallDirY
    ball.position.x = initBallPosX
    ball.position.y = initBallPosY
    love.audio.play(Audio.win)
end

function resetRandVars()
    math.randomseed(os.time())
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
    ball.dir.x = randX
    ball.dir.y = randY

    ball:resetInitTime()
    ball:resetSpd()
    love.audio.play(Audio.startGame)

    if Config.win then
        Config.win = false
        resetScore()
    end
end

function resetScore()
    player1.score = 0
    player2.score = 0
end

function increaseScore(player)
    if player.score < scoreToWin-1  then
        player.score = player.score + 1
    else
        -- Ecran de Win !
        player.score = player.score + 1
        Config.win = true
        print(ball.spd + (os.time() - initTime) * 10)
    end
end

local boundaries = {
    top = Rectangle:new("line", -5, -5, 1000, 11),
    bot = Rectangle:new("line", -5, 594, 1000, 11),
    left = Rectangle:new("line", -5, -5, 11, 700),
    right = Rectangle:new("line", 800-16, -5, 300, 700),
}

function love.load()
    -- Paramètres Fenètre
    love.window.setMode( Config.screenWidth, Config.screenHeight )
    love.window.setTitle(Config.title)
    love.graphics.setNewFont("Anta-Regular.ttf", 18)

    -- Charger l'audio
    love.audio.setVolume(0.1)
    Audio.music:setLooping(true)
    Audio.music:setVolume(0.06)
    Audio.startGame:setVolume(0.4)
    Audio.startGame:setLooping(false)
    Audio.win:setLooping(false)
    Audio.marquerPoint:setLooping(false)
    love.audio.play(Audio.music)
    
    -- Charger les joueurs
    player1 = Player:new(400, 400, {x=0,y=0}, {x=30,y=250}, {width=16,height=64}, "1", 0)
    player2 = Player:new(400, 400, {x=0,y=0}, {x=800-46,y=250}, {width=16,height=64}, "2", 0)
    ball = Ball:new(200, 1000, 200, {x=initBallDirX,y=initBallDirY}, {x=initBallPosX,y=initBallPosY}, {width=16,height=16})
    -- Charger le terrain
    leftGroundRect = Rectangle:new("line", 5, 5, 395, 590)
    rightGroundRect = Rectangle:new("line", 400, 5, 395, 590)
end


function love.keypressed(key, scancode, isinstance)
    if key == "escape" then
        love.event.quit()
    end
    if key == "space" and ball.dir.x == 0 then
        resetRandVars()
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
    ball:increaseSpd()
    ball.shape.x = ball.position.x
    ball.shape.y = ball.position.y
    ball:changeDirection(player1.shape)
    ball:changeDirection(player2.shape)
    ball:changeDirection(boundaries.top)
    ball:changeDirection(boundaries.bot)

    if ball:detectGoal(boundaries.right) then
        increaseScore(player1)
        love.audio.play(Audio.marquerPoint)
        resetBallPosition()
    end
    if ball:detectGoal(boundaries.left) then
        increaseScore(player2)
        love.audio.play(Audio.marquerPoint)
        resetBallPosition()
    end

    
end

function love.draw()
    love.graphics.rectangle(player1.shape:rectUnpack())
    love.graphics.rectangle(player2.shape:rectUnpack())
    love.graphics.rectangle(ball.shape:rectUnpack())
    love.graphics.rectangle(leftGroundRect:rectUnpack())
    love.graphics.rectangle(rightGroundRect:rectUnpack())
    printScore()
    if Config.win then
        if player1.score == scoreToWin then
            printWin(player1)
        else
            printWin(player2)
        end
    end
end