PipePair = Class{}

--GAP_HEIGHT = math.random(40,80)

function PipePair:init(y)
  self.x = VIRTUAL_WIDTH
  self.y = y
  self.GAP_HEIGHT = math.random(40,80)
  self.pipes = {
    ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + 30 + self.GAP_HEIGHT),
    ['upper'] = Pipe('top', self.y)
  }
  self.remove = false

end

function PipePair:update(dt)
  if self.x > -PIPE_WIDTH then
    self.x = self.x + PIPE_SCROLL * dt
    self.pipes['lower'].x = self.x
    self.pipes['upper'].x = self.x
  else
    self.remove = true
  end
  self.GAP_HEIGHT = math.random(40,80)
end

function PipePair:render()
  for k, pipe in pairs(self.pipes) do
    pipe:render()
  end
end
