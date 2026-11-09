-- LOADING SYSTEM

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local LOAD_DURATION = 90

-- CLEAN OLD GUI
local old = playerGui:FindFirstChild("LoadingSystem")
if old then
    old:Destroy()
end

-- SCREEN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingSystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- MAIN WINDOW
local frame = Instance.new("Frame")
frame.Name = "MainWindow"
frame.Size = UDim2.fromOffset(340, 205)
frame.Position = UDim2.new(0.5, -170, 0.5, -102)
frame.BackgroundColor3 = Color3.fromRGB(23, 45, 73)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(65, 91, 120)
outline.Thickness = 1
outline.Parent = frame

-- HEADER (DRAG AREA)
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 53)
header.BackgroundTransparency = 1
header.Active = true
header.Parent = frame

-- ICON
local icon = Instance.new("Frame")
icon.Size = UDim2.fromOffset(32, 32)
icon.Position = UDim2.fromOffset(12, 10)
icon.BackgroundColor3 = Color3.fromRGB(245, 185, 75)
icon.BorderSizePixel = 0
icon.Parent = header

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 7)
iconCorner.Parent = icon

local iconText = Instance.new("TextLabel")
iconText.Size = UDim2.fromScale(1, 1)
iconText.BackgroundTransparency = 1
iconText.Text = "L"
iconText.TextColor3 = Color3.fromRGB(23, 45, 73)
iconText.Font = Enum.Font.GothamBold
iconText.TextSize = 20
iconText.Parent = icon

-- TITLE
local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(54, 9)
title.Size = UDim2.new(1, -110, 0, 34)
title.BackgroundTransparency = 1
title.Text = "LOADING SYSTEM"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- STATUS BADGE
local badge = Instance.new("TextLabel")
badge.Size = UDim2.fromOffset(65, 22)
badge.Position = UDim2.new(1, -77, 0, 15)
badge.BackgroundColor3 = Color3.fromRGB(35, 90, 75)
badge.Text = "ACTIVE"
badge.TextColor3 = Color3.fromRGB(105, 235, 165)
badge.Font = Enum.Font.GothamBold
badge.TextSize = 10
badge.Parent = header

local badgeCorner = Instance.new("UICorner")
badgeCorner.CornerRadius = UDim.new(1, 0)
badgeCorner.Parent = badge

-- DIVIDER
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -24, 0, 1)
divider.Position = UDim2.fromOffset(12, 53)
divider.BackgroundColor3 = Color3.fromRGB(65, 85, 110)
divider.BorderSizePixel = 0
divider.Parent = frame

-- STATUS TEXT
local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(12, 67)
status.Size = UDim2.new(1, -24, 0, 22)
status.BackgroundTransparency = 1
status.Text = "Initializing..."
status.TextColor3 = Color3.fromRGB(175, 195, 215)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

-- BAR BACKGROUND
local barBG = Instance.new("Frame")
barBG.Position = UDim2.fromOffset(12, 101)
barBG.Size = UDim2.new(1, -24, 0, 10)
barBG.BackgroundColor3 = Color3.fromRGB(53, 72, 96)
barBG.BorderSizePixel = 0
barBG.ClipsDescendants = true
barBG.Parent = frame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBG

-- PROGRESS BAR
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(245, 185, 75)
bar.BorderSizePixel = 0
bar.Parent = barBG

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = bar

-- PERCENTAGE
local percent = Instance.new("TextLabel")
percent.Position = UDim2.fromOffset(12, 120)
percent.Size = UDim2.new(1, -24, 0, 35)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.TextColor3 = Color3.new(1, 1, 1)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 23
percent.TextXAlignment = Enum.TextXAlignment.Left
percent.Parent = frame

-- FOOTER
local footer = Instance.new("TextLabel")
footer.Position = UDim2.fromOffset(12, 171)
footer.Size = UDim2.new(1, -24, 0, 20)
footer.BackgroundTransparency = 1
footer.Text = "PLEASE WAIT WHILE THE SYSTEM LOADS"
footer.TextColor3 = Color3.fromRGB(135, 160, 190)
footer.Font = Enum.Font.Gotham
footer.TextSize = 9
footer.TextXAlignment = Enum.TextXAlignment.Left
footer.Parent = frame

-- DRAG FUNCTION (MOUSE + TOUCH)
local dragging = false
local dragStart
local startPosition
local dragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- LOADING ANIMATION
for i = 1, 100 do
    percent.Text = i .. "%"
    status.Text = "Loading... Please wait."

    local tween = TweenService:Create(
        bar,
        TweenInfo.new(LOAD_DURATION / 100, Enum.EasingStyle.Linear),
        {Size = UDim2.new(i / 100, 0, 1, 0)}
    )

    tween:Play()
    tween.Completed:Wait()
end

-- COMPLETED
status.Text = "Loading complete!"
badge.Text = "READY"
badge.TextColor3 = Color3.fromRGB(105, 235, 165)

task.wait(2)
gui:Destroy()
