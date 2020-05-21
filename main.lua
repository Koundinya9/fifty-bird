push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountDownState'



WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0
local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

scrolling = true

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('FIFTY BIRD')
  math.randomseed(os.time())
  sounds = {
    ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static'),
    ['pause'] = love.audio.newSource('sounds/Pickup_Coin4.wav', 'static')
  }

  sounds['music']:setLooping(true)
  sounds['music']:play()

  smallFont = love.graphics.newFont('font.ttf', 8)
  mediumFont = love.graphics.newFont('flappy.ttf', 14)
  flappyFont = love.graphics.newFont('flappy.ttf', 28)
  hugeFont = love.graphics.newFont('flappy.ttf', 56)
  love.graphics.setFont(flappyFont)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizeable = true
  })

  gStateMachine = StateMachine {
    ['title'] = function() return TitleScreenState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end,
    ['countdown'] = function() return CountDownState() end,

  }
  gStateMachine:change('title')
love.keyboard.keysPressed = {}
love.mouse.buttonsPressed = {}

end

function love.resize(w, h)
  push:resize(w, h)
end

function love.mousePressed(x, y, button)
  love.mouse.buttonsPressed[button] = true
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.mouse.wasPressed(key)
  if love.mouse.buttonsPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
  if scrolling == true then
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
  end
  gStateMachine:update(dt)
  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()
  love.graphics.draw(background, -backgroundScroll, 0)
  gStateMachine:render()
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  push:finish()
end
