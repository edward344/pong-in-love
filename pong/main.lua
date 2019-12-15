function love.load()
    love.window.setTitle("Pong")
    love.window.setMode(640,480)

    Object = require "classic"
    require "game"
    
    game = Game()
    
    love.graphics.setNewFont("kenvector_future.ttf",45)
end

function love.update(dt)
    game:run_logic(dt)
end

function love.draw()
    game:display_frame()
end

function love.keypressed(key)
    game:event_keydown(key)   
end

function love.keyreleased(key)
    game:event_keyup(key)
end