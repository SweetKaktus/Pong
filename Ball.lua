local Entity = require("Entity")
local Audio = require("Audio")

local Ball = setmetatable({}, {__index = Entity})

function Ball:new(spd, maxSpd, initSpd, dir, position, size)
    local instance = Entity:new(spd or 0, maxSpd or 0, dir or {x = 1, y = -0.5}, position or {x = 0, y = 0}, size or {width = 32, height = 32})
    setmetatable(instance, {__index = self})
    instance.initTime = os.time()
    instance.initSpd = initSpd or 0
    return instance
end

function Ball:checkCollision(target)
    shapeLeft = self.shape.x
    shapeRight = self.shape.x + self.shape.width
    shapeTop = self.shape.y
    shapeBot = self.shape.y + self.shape.height

    tShapeLeft = target.x
    tShapeRight = target.x + target.width
    tShapeTop = target.y
    tShapeBot = target.y + target.height
    

-- Le bloc ci-dessous peut être simplifié pour directement retourner la valeur de la comparaison (cf. plus bas)
    if shapeLeft < tShapeRight
    and shapeRight > tShapeLeft
    and shapeTop < tShapeBot
    and shapeBot > tShapeTop
    then
        collList = {}
        collList.left = tShapeRight - shapeLeft
        collList.right = shapeRight - tShapeLeft
        collList.top = tShapeBot - shapeTop
        collList.bot = shapeBot - tShapeTop
        local smallest = math.huge
        local side = nil
        for k,v in pairs(collList) do
            if math.abs(v) < math.abs(smallest) then
                smallest = v
                side = k
            end
        end
        return side
    end
    return false
end


function Ball:changeDirection(target)
    local side = self:checkCollision(target)
    
    if side == "left" or side == "right" then
        self.dir.x = -self.dir.x
        love.audio.play(Audio.impact)
    end
    if side == "top" or side == "bot" then
        self.dir.y = -self.dir.y
        love.audio.play(Audio.impact)
    end
end

function Ball:detectGoal(target)
    local side = self:checkCollision(target)
    if side == "right" or side == "left" then
        -- player1 wins
        return true
    else
        return false
    end
end

function Ball:increaseSpd()
    if self.spd < self.maxSpd then
        self.spd = self.spd + (os.time() - self.initTime) / 60
    end
end

function Ball:resetInitTime()
    self.initTime = os.time()
end

function Ball:resetSpd()
    self.spd = self.initSpd
end

return Ball