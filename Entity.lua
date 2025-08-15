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
    instance.shape = shape or Rectangle:new("fill", self.position.x, self.position.y, self.size.width, self.size.height)
    return instance
end

function Entity:move(spd, dir)
    -- Fonction pour bouger l'entité dans une certaine direction
end

function Entity:changeDir()
    -- Fonction pour changer la direction, doit récupérer la touche appuyer pour appliquer un certain vecteur en fonction de cette touche
end

function Entity:checkCollision(target)
    -- Fonction pour vérifier si l'entité rentre en collision avec une autre entité
end