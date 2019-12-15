Enemy = Object:extend()

function Enemy:new(width,height)
    self.x = 0
    self.y = 0
    self.width = width
    self.height = height
end

function Enemy:set_pos(x,y)
    self.x = x
    self.y = y
end

function Enemy:draw()
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end