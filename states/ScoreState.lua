ScoreState = Class{__includes = BaseState}

local bronzecup = love.graphics.newImage('bronze_cup.png')
local silvercup = love.graphics.newImage('silver_cup.png')
local goldcup = love.graphics.newImage('gold_cup.png')

function ScoreState:enter(params)
  self.score = params.score
end

function ScoreState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('countdown')
  end
end

function ScoreState:render()
  love.graphics.setFont(flappyFont)
  love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(mediumFont)
  love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
  if self.score >= 5 and self.score < 10 then
    love.graphics.printf('You are awarded the bronze cup for scoring 5 points ', 0, 120, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(bronzecup, VIRTUAL_WIDTH / 2 - 11, VIRTUAL_HEIGHT / 2 - 10 )

  elseif self.score >= 10 and self.score < 15 then
    love.graphics.printf('You are awarded the silver cup for scoring 10 points ', 0, 120, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(silvercup,  VIRTUAL_WIDTH / 2 - 11, VIRTUAL_HEIGHT / 2 - 10  )
  elseif self.score >= 15 then
    love.graphics.printf('You are awarded the gold cup for scoring 15 points ', 0, 120, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(goldcup,  VIRTUAL_WIDTH / 2 - 11, VIRTUAL_HEIGHT / 2 - 10 )
  end
  love.graphics.printf('Press Enter to Play Again!', 0, 170, VIRTUAL_WIDTH, 'center')
end
