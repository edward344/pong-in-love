Player = Object:extend()

function Player:new(width,height)
    self.x = 0
    self.y = 0
    self.width = width
    self.height = height
    self.change = 0
end

function Player:update(dt)
    -- Check for limits
    if self.y <= 0 and self.change < 0 then
        self.change = 0
    elseif self.y + self.height >= love.graphics.getHeight() and self.change > 0 then
        self.change = 0
    end
    
    -- Move player
    self.y = self.y + self.change * dt
    
end

function Player:draw()
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end

function Player:set_pos(x,y)
    self.x = x
    self.y = y
end

function Player:go_up()
    self.change = -100
end

function Player:go_down()
    self.change = 100
end

function Player:stop()
    self.change = 0
end