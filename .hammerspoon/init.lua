hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "space", function()
  local chrome = hs.application.find("Chrome")
  local moveToTab = {"Tab", "Move Tab to New Window"} 
  chrome:selectMenuItem(moveToTab)

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)

end)


local function getCurrentWidthIndex(widths, f, max)
  for i, width in ipairs(widths) do
    if math.abs(f.w - (max.w * width)) < 1 then
      return i
    end
  end
  return 1
end

local function getCurrentPositionIndex(numPositions, f, max, currentWidth)
  for i = 0, numPositions - 1 do
    if math.abs(f.x - (max.x + i * max.w * currentWidth)) < 1 then
      return i
    end
  end
  return 0
end

local function setWindowPosition(win, direction)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local screenWidth = max.w
  local widths = screenWidth < 2000 and {0.5, 0.66, 0.75} or {0.25, 0.33, 0.5, 0.66, 0.75}
  local currentWidthIndex = getCurrentWidthIndex(widths, f, max)

  local currentWidth = widths[currentWidthIndex]
  local nextWidthIndex = (currentWidthIndex + direction - 1) % #widths + 1
  local nextWidth = widths[nextWidthIndex]

  local numPositions = math.floor(1 / currentWidth)
  local currentPositionIndex = getCurrentPositionIndex(numPositions, f, max, currentWidth)

  if direction == 1 then
    if currentPositionIndex == numPositions - 1 then
      currentWidth = nextWidth
      currentPositionIndex = 0
    else
      currentPositionIndex = currentPositionIndex + 1
    end
  else
    if currentPositionIndex == 0 then
      currentWidth = nextWidth
      currentPositionIndex = math.floor(1 / currentWidth) - 1
    else
      currentPositionIndex = currentPositionIndex - 1
    end
  end

  f.x = max.x + currentPositionIndex * max.w * currentWidth
  f.y = max.y
  f.w = max.w * currentWidth
  f.h = max.h
  win:setFrame(f)

  hs.alert.show(string.format("Width: %d%%, Position: %d", currentWidth * 100, currentPositionIndex + 1))
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  setWindowPosition(win, 1)

end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()

  local win = hs.window.focusedWindow()
  setWindowPosition(win, -1)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  hs.alert.show("Move Screen")
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect 
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
  hs.alert.show("3/4 or full Screen")

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- hs.alert.show(math.floor(f.w/10) .. " = " .. math.floor(max.w / 4 * 3 / 10))
  
  if math.floor(f.w/10) ~= math.floor(max.w / 4 * 3 / 10) then
    f.x = max.x + max.w / 4 
    f.y = max.y
    f.w = max.w / 4 * 3
    f.h = max.h
  else
    f.x = max.x
    f.y = max.y
    f.w = max.w 
    f.h = max.h
  end
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", function()
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
