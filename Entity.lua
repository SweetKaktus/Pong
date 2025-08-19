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
    -- Code corrigé où je contraint avec les fonctions du module intégré "math" la position en Y

    -- Appliquer le mouvement
    if self.dir.y ~= 0 then
        self.position.y = self.position.y + self.spd * self.dir.y * dt
        self.position.x = self.position.x + self.spd * self.dir.x * dt
    end
    -- Contraindre la position Y dans les limites
    self.position.y = math.max(5, math.min(self.position.y, 595 - self.size.height))
    self.position.x = math.max(5, math.min(self.position.x, 795))
    
    
    -- Mes tests : PB => Je fais la vérif après avoir déplacé, il faut la faire avant comme ci-dessus
    -- -- Fonction pour bouger l'entité dans une certaine direction
    -- -- MODIFIER LA FONCTION POUR PRENDRE EN COMPTE LE SCREEN WIDT + HEIGHT
    -- if self.position.y >= 5 and self.position.y <= 590 - 64 then
    --     self.position.y = self.position.y + self.spd * self.dir.y * dt
    --     self.position.x = self.position.x + self.spd * self.dir.x * dt
    -- elseif self.position.y < 5 then
    --     self.position.y = 5
    -- elseif self.position.y > 590 - 64 then
    --     self.position.y = 590 - 64
    -- end
end

function Entity:checkCollision(target)
    local shapeLeft = self.shape.x
    local shapeRight = self.shape.x + self.shape.width
    local shapeTop = self.shape.y
    local shapeBot = self.shape.y + self.shape.height

    local tShapeLeft = target.shape.x
    local tShapeRight = target.shape.x + target.shape.width
    local tShapeTop = target.shape.y
    local tShapeBot = target.shape.y + target.shape.height
    

-- Le bloc ci-dessous peut être simplifié pour directement retourner la valeur de la comparaison (cf. plus bas)
    -- if rect1Left < rect2Right
    -- and rect1Right > rect2Left
    -- and rect1Top < rect2Bot
    -- and rect1Bot > rect2Top
    -- then
    --     return true
    -- end
    -- return false

    return shapeLeft < tShapeRight
    and shapeRight > tShapeLeft
    and shapeTop < tShapeBot
    and shapeBot > tShapeTop
end

return Entity