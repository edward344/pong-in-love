Menu = Object:extend()

function Menu:new(items)
    self.state = 0
    self.items = items
end

function Menu:display_frame()
    local font = love.graphics.getFont()
  
    for i = 1, #self.items do
        local text = self.items[i] 
        
        if self.state == i - 1 then
            love.graphics.setColor(1,0,0)
        else
            love.graphics.setColor(1,1,1)
        end
       
        local width = font:getWidth(text)
        local height = font:getHeight()
        
        local posX = (love.graphics.getWidth() / 2) - (width / 2)
        -- t_h: total height of text block
        local t_h = #self.items * height
        
        local posY = (love.graphics.getHeight() / 2) - (t_h /2) + ((i - 1) * height)
        
        love.graphics.print(text,posX,posY)
    end
end

function Menu:event_handler(key)
    if key == "up" then
        if self.state > 0 then
            self.state = self.state - 1
        end
    elseif key == "down" then
        if self.state < #self.items - 1 then
            self.state = self.state + 1
        end
    end
end