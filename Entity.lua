local Rectangle = require("Rectangle")

local Entity = {}

function Entity:new(spd, maxSpd, dir, position, size)
    local instance = {}
    setmetatable(instance, {__index = self})
    instance.spd = spd or 0
    instance.dir = dir or {x = 0, y = 0}
    instance.maxSpd = maxSpd or 0
    instance.position = position or {x = 0, y = 0}
    instance.size = size or {width = 64, height = 128}
    instance.shape = shape or Rectangle:new("fill", instance.position.x, instance.position.y, instance.size.width, instance.size.height)
    return instance
end

function Entity:move(dt)
    -- Appliquer le mouvement
    if self.dir.y ~= 0 then
        self.position.y = self.position.y + self.spd * self.dir.y * dt
        self.position.x = self.position.x + self.spd * self.dir.x * dt
    end
    -- Contraindre la position Y dans les limites
    self.position.y = math.max(5, math.min(self.position.y, 595 - self.size.height))
    self.position.x = math.max(5, math.min(self.position.x, 800-16-5))
    
end

return Entity