local Entity = require("Entity")

local Player = setmetatable({}, {__index = Entity})

function Player:new(spd, maxSpd, dir, position, size, playerNumber)
    local instance = Entity:new(spd or 0, maxSpd or 0, dir or {x = 0, y = 0}, position or {x = 0, y = 0}, size or {width = 32, height = 64})
    setmetatable(instance, {__index = self})
    instance.playerNumber = playerNumber or "1"
    return instance
end

function Player:setDirectionBasedOnPlayerNumber()
    if self.playerNumber == "2" then
        if love.keyboard.isDown("up") then
            self.dir.y = -1
        elseif love.keyboard.isDown("down") then
            self.dir.y = 1
        else self.dir.y = 0
        end
    elseif self.playerNumber == "1" then
        if love.keyboard.isDown("w", "z") then
            self.dir.y = -1
        elseif love.keyboard.isDown("s") then
            self.dir.y = 1
        else self.dir.y = 0
        end
    end
end

return Player