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


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  local thirdWidth = max.w / 3

  if math.abs(f.x - max.x) < 1 then
    f.x = max.x + thirdWidth
    hs.alert.show("Middle Third (33%)")
  elseif math.abs(f.x - (max.x + thirdWidth)) < 1 then
    hs.alert.show("Right Third (33%)")
    f.x = max.x + 2 * thirdWidth
  else
    f.x = max.x
    hs.alert.show("Left Third (33%)")
  end

  f.y = max.y
  f.w = thirdWidth
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if math.abs(f.x - max.x) < 1 then
    -- Move to right half
    hs.alert.show("Right Half (50%)")
    f.x = max.x + (max.w / 2)
  else
    -- Move to left half
    hs.alert.show("Left Half (50%)")
    f.x = max.x
  end

  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
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
