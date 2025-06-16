-- launch and focus applications with below shortkey
hs.fnutils.each({
    { key = "`", app = "iTerm" },
    { key = "c", app = "Google Chrome" },
    { key = "d", app = "TickTick" },
    { key = "e", app = "Finder" },
    { key = "f", app = "Lark" },
    { key = "i", app = "IntelliJ IDEA" },
    { key = "j", app = "Activity Monitor" },
    { key = "k", app = "KeePassXC" },
    { key = "l", app = "灵犀" },
    { key = "n", app = "Microsoft OneNote" },
    { key = "o", app = "Microsoft Word" },
    -- { key = "p", app = "PyCharm" },
    { key = "q", app = "QQ体验版" },
    { key = "s", app = "TwinklingCard" },
    -- { key = "v", app = "Visual Studio Code" },
    { key = "v", app = "Cursor" },
    { key = "w", app = "WeChat" },
    { key = "y", app = "QQMusic" },
}, function(object)
    launchApp(mash.app, object)
end)

hs.fnutils.each({
    { key = "g", app = "DataGrip" },
    -- { key = "c", app = "ChatGPT" },
}, function(object)
    launchApp(mash.resize, object)
end)

------------------------------------------------------------
-- Window resize
------------------------------------------------------------

hs.hotkey.bind(mash.resize, "m", function()
    maximizeCurrentWindow()
end)

hs.hotkey.bind(mash.resize, "-", function()
    smallerCurrentWindow()
end)

hs.hotkey.bind(mash.resize, "=", function()
    largerCurrentWindow()
end)

hs.hotkey.bind(mash.resize, "left", function()
    leftHalfCurrentWindow()
end)

hs.hotkey.bind(mash.resize, "right", function()
    rightHalfCurrentWindow()
end)

hs.hotkey.bind(mash.resize, "up", function()
    upHalfCurrentWindow()
end)

hs.hotkey.bind(mash.resize, "down", function()
    downHalfCurrentWindow()
end)

-- Window fit screen height
hs.hotkey.bind(mash.resize, "h", function()
    fitScreenHeight()
end)

hs.hotkey.bind(mash.resize, "w", function()
    fitScreenWidth()
end)

------------------------------------------------------------
-- Window movement 
------------------------------------------------------------
-- Window <
hs.hotkey.bind(mash.movement, "left", function()
    moveCurrentWindow(-100, 0)
end)
-- Window >
hs.hotkey.bind(mash.movement, "right", function()
    moveCurrentWindow(100, 0)
end)
-- Window ^
hs.hotkey.bind(mash.movement, "up", function()
    moveCurrentWindow(0, -100)
end)
-- Window v
hs.hotkey.bind(mash.movement, "down", function()
    moveCurrentWindow(0, 100)
end)

-- move to next screen
hs.hotkey.bind(mash.movement, "n", function()
    moveToNextScreen()
end)

hs.hotkey.bind({"ctrl", "alt", "shift"},  "n", function()
    moveToNextScreen()
    maximizeCurrentWindow() 
end)


