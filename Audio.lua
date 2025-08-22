local Audio = {
    music = love.audio.newSource("Music.mp3", "stream"),
    impact = love.audio.newSource("Impact.ogg", "static"),
    startGame = love.audio.newSource("StartGame.ogg", "static"),
    win = love.audio.newSource("Win.ogg", "static"),
    marquerPoint = love.audio.newSource("MarquerPoint.ogg", "static"),
}


return Audio