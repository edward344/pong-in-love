Game = Object:extend()

function Game:new()
    require "menu"
    -- create menu.
    self.menu = Menu({"start","about","exit"})
    self.show_menu = true -- True: display the menu
    self.show_about_frame = false
    -- create ball
    require "ball"
    self.ball = Ball(10,10)
    -- create Player
    require "player"
    self.player = Player(15,50)
    -- create enemy
    require "enemy"
    self.enemy = Enemy(15,50)
    -- load sound
    self.sound = love.audio.newSource("sfx_sounds_Blip3.ogg","stream")
    -- count the score of the player
    self.player_score = 0
    -- count the score of the enemy
    self.enemy_score = 0
    self.game_over = false -- true: when someone wins...
end

function Game:event_keydown(key)
    self.menu:event_handler(key)
    
    if key == "return" then
        if self.show_menu then
            if self.menu.state == 0 then
                self.show_menu = false
                -- initialize all variables
                self.ball:set_pos(love.graphics.getWidth() /2, love.graphics.getHeight() /2)
                self.ball:set_dir(-150,0)
                self.player:set_pos(50,(love.graphics.getHeight() / 2) - 25)
                self.enemy:set_pos(love.graphics.getWidth() - 65,(love.graphics.getHeight() / 2) - 25)
                self.player_score = 0
                self.enemy_score = 0
            elseif self.menu.state == 1 then
                self.show_about_frame = true
                self.show_menu = false
            elseif self.menu.state == 2 then
                love.event.quit()
            end
        end
    elseif key == "up" then
        self.player:go_up()
    elseif key == "down" then
        self.player:go_down()
    elseif key == "escape" then
        self.show_menu = true
        self.show_about_frame = false
        self.game_over = false
    end
end

function Game:event_keyup(key)
    if key == "up" or key == "down" then
        self.player:stop()
    end
end

function Game:colliderect(rect1,rect2)
    -- check if two rects collide
    local left1 = rect1.x
    local right1 = rect1.x + rect1.width
    local top1 = rect1.y
    local bottom1 = rect1.y + rect1.height
    
    local left2 = rect2.x
    local right2 = rect2.x + rect2.width
    local top2 = rect2.y
    local bottom2 = rect2.y + rect2.height
    
    if left1 < right2 and right1 > left2 and top1 < bottom2 and bottom1 > top2 then
        return true
    else
        return false
    end
end

function Game:run_logic(dt)
    if not self.show_menu and not self.show_about_frame and not self.game_over then
        -- update ball
        self.ball:update(dt)
        -- update player
        self.player:update(dt)
        -- update enemy
        if self.ball.change_y > 100 then
            self.enemy.y = self.enemy.y + 100 * dt
        elseif self.ball.change_y < -100 then
            self.enemy.y = self.enemy.y - 100 * dt
        else
            self.enemy.y = self.enemy.y + self.ball.change_y * dt
        end
        -- check if ball and player collide
        if self:colliderect(self.ball,self.player) then
            self.ball.x = self.player.x + self.player.width
            self.ball:change_dir_random()
            self.sound:play() -- play the sound
        -- check if ball and enemy collide
        elseif self:colliderect(self.ball,self.enemy) then
            self.ball.x = self.enemy.x - self.ball.width
            self.ball:change_dir()
            self.sound:play() -- play the sound
        end
        -- check if one score
        if self.ball.x < 0 then
            self.enemy_score = self.enemy_score + 1 -- increase score
            -- reset the game
            self.ball:set_pos(love.graphics.getWidth() /2, love.graphics.getHeight() /2)
            self.ball:set_dir(-150,0)
            self.player:set_pos(50,(love.graphics.getHeight() / 2) - 25)
            self.enemy:set_pos(love.graphics.getWidth() - 65,(love.graphics.getHeight() / 2) - 25)
        elseif self.ball.x > love.graphics.getWidth() then
            self.player_score = self.player_score + 1 -- increase score
            -- reset the game
            self.ball:set_pos(love.graphics.getWidth() /2, love.graphics.getHeight() /2)
            self.ball:set_dir(-150,0)
            self.player:set_pos(50,(love.graphics.getHeight() / 2) - 25)
            self.enemy:set_pos(love.graphics.getWidth() - 65,(love.graphics.getHeight() / 2) - 25)
        end
        
    end
end

function Game:display_frame()
    if self.show_menu then
        -- display menu
        self.menu:display_frame()
    elseif self.show_about_frame then
        -- display about...
        self:display_message("by edu grando")
    elseif self.player_score == 20 then
        -- if the player wins...
        self:display_message("You Won!")
        self.game_over = true
    elseif self.enemy_score == 20 then
        -- if enemy wins...
        self:display_message("You lost")
        self.game_over = true
    else
        -- run the game
        -- Draw center line
        for i = 0, love.graphics.getHeight(), 20 do
            love.graphics.rectangle("fill",love.graphics.getWidth() / 2,i,10,10)
        end
        -- Draw the score
        love.graphics.print(self.player_score,270,10)
        love.graphics.print(self.enemy_score,350,10)
        -- draw ball
        self.ball:draw()
        -- draw player
        self.player:draw()
        -- draw enemy
        self.enemy:draw()
    end
end

function Game:display_message(message)
    local font = love.graphics.getFont()
    
    local width = font:getWidth(message)
    local height = font:getHeight()
    
    local posX = (love.graphics.getWidth() / 2) - (width / 2)
    local posY = (love.graphics.getHeight() / 2) - (height / 2)
    
    love.graphics.print(message,posX,posY)
end