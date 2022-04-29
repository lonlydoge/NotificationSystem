local NotificationUI = Instance.new("ScreenGui")
local NotificationFrame = Instance.new("Frame")
local Notification = Instance.new("Frame")
local Rounder = Instance.new("UICorner")
local Image = Instance.new("Frame")
local RounderAgain = Instance.new("UICorner")
local ColorThing = Instance.new("UIGradient")
local InfoImage = Instance.new("ImageLabel")
local NotificationText = Instance.new("TextLabel")
local NotificationPositioner = Instance.new("UIListLayout")

if game.CoreGui:FindFirstChild("NotificationUI") then
    game.CoreGui:FindFirstChild("NotificationUI"):Destroy()
end

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

NotificationUI.Parent = game.CoreGui
NotificationUI.Name = "NotificationUI"

NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Parent = NotificationUI
NotificationFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
NotificationFrame.Size = UDim2.new(0, 343, 0, 491)
NotificationFrame.Position = UDim2.new(0, 0, .4, 6)
NotificationFrame.BackgroundTransparency = 1

Notification.Name = "Notification"
Notification.Parent = nil
Notification.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Notification.BackgroundTransparency = 1
Notification.Position = UDim2.new(0.0524781346, 0, 0.812627316, 0)
Notification.Size = UDim2.new(0, 307, 0, 37)

Rounder.CornerRadius = UDim.new(0, 4)
Rounder.Name = "Rounder"
Rounder.Parent = Notification

Image.Name = "Image"
Image.Parent = Notification
Image.BackgroundTransparency = 1
Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Image.Size = UDim2.new(0, 42, 0, 37)

RounderAgain.CornerRadius = UDim.new(0, 5)
RounderAgain.Name = "RounderAgain"
RounderAgain.Parent = Image

ColorThing.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(115, 0, 255))}
ColorThing.Name = "ColorThing"
ColorThing.Parent = Image

InfoImage.Name = "InfoImage"
InfoImage.Parent = Image
InfoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InfoImage.BackgroundTransparency = 1.000
InfoImage.Position = UDim2.new(0.142857149, 0, 0.0810811222, 0)
InfoImage.Size = UDim2.new(0, 30, 0, 30)
InfoImage.Image = "http://www.roblox.com/asset/?id=6031071057"
InfoImage.ImageTransparency = 1

NotificationText.Name = "NotificationText"
NotificationText.Parent = Notification
NotificationText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.BackgroundTransparency = 1.000
NotificationText.Position = UDim2.new(0.159609124, 0, 0.297297299, 0)
NotificationText.Size = UDim2.new(0, 204, 0, 15)
NotificationText.Font = Enum.Font.Gotham
NotificationText.Text = ""
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextScaled = true
NotificationText.TextSize = 14.000
NotificationText.TextWrapped = true
NotificationText.TextTransparency = 1
NotificationText.TextXAlignment = Enum.TextXAlignment.Left

NotificationPositioner.Name = "NotificationPositioner"
NotificationPositioner.Parent = NotificationFrame
NotificationPositioner.SortOrder = Enum.SortOrder.LayoutOrder
NotificationPositioner.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotificationPositioner.Padding = UDim.new(0, 5)

-- UI Done

local System = {}

function System.Notify(Text, Duration)
    local transparencyData = {
        ["NotificationText"] = "TextTransparency",
        ["Image"] = "BackgroundTransparency",
        ["InfoImage"] = "ImageTransparency";
    }
    local clonedNotification = Notification:Clone()

    clonedNotification.NotificationText.Text = Text
    clonedNotification.Parent = NotificationFrame

    local Tween = TweenService:Create(clonedNotification, TweenInfo.new(.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {BackgroundTransparency = 0})
    Tween:Play()

    for _, v in pairs(clonedNotification:GetDescendants()) do
        for i, data in pairs(transparencyData) do
            if i == v.Name then
                local Tween = TweenService:Create(v, TweenInfo.new(.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {[data] = 0})
                Tween:Play()
            end
        end
    end

    task.delay(Duration, function()
        local Tween = TweenService:Create(clonedNotification, TweenInfo.new(.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        Tween:Play()
    
        for _, v in pairs(clonedNotification:GetDescendants()) do
            for i, data in pairs(transparencyData) do
                if i == v.Name then
                    local Tween = TweenService:Create(v, TweenInfo.new(.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {[data] = 1})
                    Tween:Play()
                end
            end
        end

        Debris:AddItem(clonedNotification, .5)
    end)
end

return System
