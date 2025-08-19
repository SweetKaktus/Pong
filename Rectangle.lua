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

-- Cette fonction me permet de dépiler mes rectangles pour pouvoir les afficher dans la fonction love.graphics.rectangle
-- usage : love.graphics.rectangle(entity.shape:rectUnpack())
function Rectangle:rectUnpack()
    order = {"mode", "x", "y", "width", "height"}
    args = {}
    for _, key in ipairs(order) do
        table.insert(args, self[key])
    end
    return unpack(args)
end

return Rectangle