PlayState = Class{__includes = BaseState}



function PlayState:init()
  self.bird = Bird{}
  self.pipepairs = {}
  self.timer = 0
  self.score = 0
  self.LastY = -PIPE_HEIGHT + math.random(120)
  self.spawntimer = math.random(2,8)
end

function PlayState:update(dt)
  if scrolling == true then

    self.bird:update(dt)
    self.timer = self.timer + dt
    if self.timer > self.spawntimer then
      local y = math.max(-PIPE_HEIGHT + 10,math.min(self.LastY + math.random(-20,20),-90))
      self.LastY = y
      table.insert(self.pipepairs, PipePair(y))

      self.timer = 0
    end
  
    for k, pair in pairs(self.pipepairs) do
      pair:update(dt)

      if not pair.scored then
        if self.bird.x > pair.x + PIPE_WIDTH then
          self.score = self.score + 1
          pair.scored = true
          sounds['score']:play()
        end
      end
      for l, pipe in pairs(pair.pipes) do
          if self.bird:collision(pipe) then
              sounds['hurt']:play()
              sounds['explosion']:play()
              gStateMachine:change('score',{
              score = self.score
            })
          end
      end
    end
    for k, pair in pairs(self.pipepairs) do
      if pair.remove then
          table.remove(self.pipepairs, k)
      end
    end
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
      sounds['hurt']:play()
      sounds['explosion']:play()
      gStateMachine:change('score',{
        score = self.score
      })
    end
    self.spawntimer = math.random(2,8)

    if love.keyboard.wasPressed('p') and scrolling == true then
      scrolling = false
      sounds['music']:pause()
      sounds['pause']:play()
    end

  elseif scrolling == false then
    if love.keyboard.wasPressed('p') then
      scrolling = true
      sounds['music']:play()
    end
  end
end

function PlayState:render()

  for k, pair in pairs(self.pipepairs) do
    pair:render()
  end
  self.bird:render()
  love.graphics.setFont(flappyFont)
  love.graphics.print('Score : ' .. tostring(self.score), 8, 8)
  if scrolling == false then
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 40, VIRTUAL_HEIGHT / 2 - 30, 20, 60)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 2 - 30, 20, 60)
  end

end
