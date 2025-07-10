-- 更健壮的获取焦点窗口函数
function getFocusedWindow()
    -- 方法1: 直接获取焦点窗口
    local window = hs.window.focusedWindow()
    if window then
        return window
    end

    -- 方法2: 获取最前面的应用程序的窗口
    local app = hs.application.frontmostApplication()
    if app then
        local windows = app:allWindows()
        for _, w in ipairs(windows) do
            if w:isVisible() and not w:isMinimized() then
                return w
            end
        end
    end

    -- 方法3: 获取所有可见窗口中的第一个
    local allWindows = hs.window.allWindows()
    for _, w in ipairs(allWindows) do
        if w:isVisible() and not w:isMinimized() then
            return w
        end
    end

    -- 方法4: 尝试获取当前屏幕上的窗口
    local screen = hs.screen.mainScreen()
    if screen then
        local windows = screen:allWindows()
        for _, w in ipairs(windows) do
            if w:isVisible() and not w:isMinimized() then
                return w
            end
        end
    end

    return nil
end

-- 显示调试信息的函数
function debugWindowInfo()
    local window = hs.window.focusedWindow()
    local app = hs.application.frontmostApplication()

    local info = "Debug Info:\n"
    info = info .. "Focused Window: " .. (window and "Found" or "nil") .. "\n"
    info = info .. "Frontmost App: " .. (app and app:name() or "nil") .. "\n"

    if app then
        local windows = app:allWindows()
        info = info .. "App Windows: " .. #windows .. "\n"
        for i, w in ipairs(windows) do
            info = info .. "  Window " .. i .. ": " .. (w:isVisible() and "Visible" or "Hidden") ..
                ", " .. (w:isMinimized() and "Minimized" or "Not Minimized") .. "\n"
        end
    end

    hs.alert.show(info)
end

function maximizeCurrentWindow()
    local window = getFocusedWindow()
    if window then
        window:maximize()
    else
        hs.alert.show("No focused window found")
    end
end

function leftHalfCurrentWindow()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local screen = window:screen()
    local max = screen:frame()

    local frameOrigin = window:frame()

    local frame1 = window:frame()
    frame1.w = math.floor(max.w / 2)

    local frame2 = window:frame()
    frame2.w = math.floor(max.w / 3)

    local frame3 = window:frame()
    frame3.w = math.floor(max.w / 4)

    local frame = frame1
    if frameEquals(frameOrigin, frame1) then
        frame = frame2
    end
    if frameEquals(frameOrigin, frame2) then
        frame = frame3
    end

    frame.x = max.x
    frame.y = frame.y
    frame.h = frame.h

    window:setFrame(frame)
end

function rightHalfCurrentWindow()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local screen = window:screen()
    local max = screen:frame()

    local frameOrigin = window:frame()

    local frame1 = window:frame()
    frame1.x = max.x + math.floor(max.w / 2)
    frame1.w = math.floor(max.w / 2)

    local frame2 = window:frame()
    frame2.x = max.x + math.floor(max.w / 3) * 2
    frame2.w = math.floor(max.w / 3)

    local frame3 = window:frame()
    frame3.x = max.x + math.floor(max.w / 4) * 3
    frame3.w = math.floor(max.w / 4)

    local frame = frame1
    if frameEquals(frameOrigin, frame1) then
        frame = frame2
    end
    if frameEquals(frameOrigin, frame2) then
        frame = frame3
    end

    frame.y = frame.y
    frame.h = frame.h

    window:setFrame(frame)
end

function moveCurrentWindow(offsetX, offsetY)
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local frame = window:frame()
    moveFrame(frame, offsetX, offsetY)
    window:setFrame(frame)
end

function upHalfCurrentWindow()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local screen = window:screen()
    local max = screen:frame()

    local frameOrigin = window:frame()

    local frame1 = window:frame()
    frame1.h = math.floor(max.h / 2)

    local frame2 = window:frame()
    frame2.h = math.floor(max.h / 3)

    local frame3 = window:frame()
    frame3.h = math.floor(max.h / 4)

    local frame = frame1
    if frameEquals(frameOrigin, frame1) then
        frame = frame2
    end
    if frameEquals(frameOrigin, frame2) then
        frame = frame3
    end

    frame.x = frame.x
    frame.y = max.y
    frame.w = frame.w

    window:setFrame(frame)
end

function downHalfCurrentWindow()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local screen = window:screen()
    local max = screen:frame()

    local frameOrigin = window:frame()

    local frame1 = window:frame()
    frame1.y = max.y + math.floor(max.h / 2)
    frame1.h = math.floor(max.h / 2)

    local frame2 = window:frame()
    frame2.y = max.y + math.floor(max.h / 3) * 2
    frame2.h = math.floor(max.h / 3)

    local frame3 = window:frame()
    frame3.y = max.y + math.floor(max.h / 4) * 3
    frame3.h = math.floor(max.h / 4)

    local frame = frame1
    if frameEquals(frameOrigin, frame1) then
        frame = frame2
    end
    if frameEquals(frameOrigin, frame2) then
        frame = frame3
    end

    frame.x = frame.x
    frame.w = frame.w

    window:setFrame(frame)
end

function frameEquals(frame1, frame2)
    return frame1.x == frame2.x and frame1.y == frame2.y and frame1.w == frame2.w and frame1.h == frame2.h
end

function smallerCurrentWindow()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local frame = window:frame()

    smallerFrame(frame)
    window:setFrame(frame)
end

function largerCurrentWindow()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local frame = window:frame()

    largerFrame(frame)
    window:setFrame(frame)
end

function smallerFrame(frame)
    resizeFrame(frame, 0.9)
end

function largerFrame(frame)
    resizeFrame(frame, 1.1)
end

function resizeFrame(frame, ratio)
    frame.x = frame.x + frame.w / 2 * (1 - ratio)
    frame.y = frame.y + frame.h / 2 * (1 - ratio)
    frame.w = frame.w * ratio
    frame.h = frame.h * ratio
end

function moveFrame(frame, offsetX, offsetY)
    frame.x = frame.x + offsetX
    frame.y = frame.y + offsetY
end

function fitScreenHeight()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local frame = window:frame()

    frame.y = window:screen():frame().y
    frame.h = window:screen():frame().h

    window:setFrame(frame)
end

function fitScreenWidth()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local frame = window:frame()

    frame.x = window:screen():frame().x
    frame.w = window:screen():frame().w

    window:setFrame(frame)
end

function moveToNextScreen()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local screen = window:screen()
    local nextScreen = screen:next()
    window:moveToScreen(nextScreen)
end

function moveToPreviousScreen()
    local window = getFocusedWindow()
    if not window then
        hs.alert.show("No focused window found")
        return
    end
    local screen = window:screen()
    local nextScreen = screen:previous()
    window:moveToScreen(nextScreen)
end

-- 强制聚焦到窗口的函数
function forceFocusWindow()
    local window = getFocusedWindow()
    if window then
        window:focus()
        return true
    else
        -- 尝试激活最前面的应用程序
        local app = hs.application.frontmostApplication()
        if app then
            app:activate()
            -- 等待一下再尝试获取窗口
            hs.timer.doAfter(0.1, function()
                local newWindow = getFocusedWindow()
                if newWindow then
                    newWindow:focus()
                end
            end)
        end
        return false
    end
end

-- 获取当前屏幕上的所有可见窗口
function getVisibleWindowsOnCurrentScreen()
    local screen = hs.screen.mainScreen()
    if not screen then
        return {}
    end

    local windows = screen:allWindows()
    local visibleWindows = {}

    for _, window in ipairs(windows) do
        if window:isVisible() and not window:isMinimized() then
            table.insert(visibleWindows, window)
        end
    end

    return visibleWindows
end
