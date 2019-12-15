Ball = Object:extend()

function Ball:new(width,height)
    self.x = 0
    self.y = 0
    self.width = width
    self.height = height
    self.change_x = 0
    self.change_y = 0
end

function Ball:update(dt)
    self.x = self.x + self.change_x * dt
    self.y = self.y + self.change_y * dt
    
    if self.y < 0 then
        self.y = 0
        self.change_y = self.change_y * -1
    elseif self.y > love.graphics.getHeight() - self.height then
        self.y = love.graphics.getHeight() - self.height
        self.change_y = self.change_y * -1
    end
end

function Ball:change_dir()
    self.change_x = self.change_x * -1
end

function Ball:change_dir_random()
    local random_number = love.math.random(-5,5)
    self.change_x = self.change_x * -1
    self.change_y = random_number * 30
end

function Ball:draw()
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end

function Ball:set_pos(x,y)
    -- set initial position
    self.x = x
    self.y = y
end

function Ball:set_dir(change_x,change_y)
    self.change_x = change_x
    self.change_y = change_y
end