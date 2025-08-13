-- Cette classe va me permettre de gérer les rectangles pour mon jeu :
-- Bordures / marquages terrain ; joueurs ; balle

local Rectangle = {}

function Rectangle:new(mode, x, y, width, height)
    local instance = {
        mode = mode or "fill",
        x = x or 128,
        y = y or 128,
        width = width or 64,
        height = height or 18,
    }
    setmetatable(instance, {__index = self})
    return instance
end

return Rectangle