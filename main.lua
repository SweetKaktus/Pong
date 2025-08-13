local Rectangle = require("Rectangle")


-- Cette fonction me permet de dépiler mes rectangles pour pouvoir les afficher dans la fonction love.graphics.rectangle
-- usage : love.graphics.rectangle(rectUnpack(monRectangle))
function rectUnpack(rectangle)
    order = {"mode", "x", "y", "width", "height"}
    args = {}
    for _, key in ipairs(order) do
        table.insert(args, rectangle[key])
    end
    return unpack(args)
end


