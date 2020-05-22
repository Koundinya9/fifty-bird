CountDownState = Class{__includes = BaseState}

local COUNTDOWN_TIME = 0.75

function CountDownState:init()
  self.timer = 0
  self.countdown = 3
end

function CountDownState:update(dt)
  self.timer = self.timer + dt
  if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.countdown = self.countdown - 1

        if self.countdown == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountDownState:render()
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(self.countdown), 0, 120, VIRTUAL_WIDTH, 'center')
end
