if game.CoreGui:FindFirstChild("NotificationUI") then
    game.CoreGui:FindFirstChild("NotificationUI"):Destroy()
end

	local NotificationUI = Instance.new("ScreenGui")
local NotificationFrame = Instance.new("Frame")
local Notification = Instance.new("Frame")
local Rounder = Instance.new("UICorner")
local NotificationText = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local Image = Instance.new("Frame")
local RounderAgain = Instance.new("UICorner")
local InfoImage = Instance.new("ImageLabel")
local UIGradient_2 = Instance.new("UIGradient")
local NotificationPositioner = Instance.new("UIListLayout")

--Properties:

NotificationUI.Name = "NotificationUI"
NotificationUI.Parent = game.CoreGui

NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Parent = NotificationUI
NotificationFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
NotificationFrame.BackgroundTransparency = 1.000
NotificationFrame.Position = UDim2.new(0, 0, 1, -490)
NotificationFrame.Size = UDim2.new(0, 340, 0, 490)

Notification.Name = "Notification"
Notification.Parent = nil
Notification.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Notification.BackgroundTransparency = 1.000
Notification.Position = UDim2.new(0, 0, 1, -35)
Notification.Size = UDim2.new(0.897058845, 0, 0.0714285746, 0)

Rounder.CornerRadius = UDim.new(0, 4)
Rounder.Name = "Rounder"
Rounder.Parent = Notification

NotificationText.Name = "NotificationText"
NotificationText.Parent = Notification
NotificationText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.BackgroundTransparency = 1.000
NotificationText.Position = UDim2.new(0.150000006, 0, 0.300000012, 0)
NotificationText.Size = UDim2.new(0, 204, 0, 15)
NotificationText.Font = Enum.Font.Gotham
NotificationText.Text = "Hello"
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextScaled = true
NotificationText.TextSize = 14.000
NotificationText.TextTransparency = 1.000
NotificationText.TextWrapped = true
NotificationText.TextXAlignment = Enum.TextXAlignment.Left

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(36, 36, 36))}
UIGradient.Parent = Notification

Image.Name = "Image"
Image.Parent = Notification
Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Image.BackgroundTransparency = 1.000
Image.Size = UDim2.new(0, 40, 0, 35)

RounderAgain.CornerRadius = UDim.new(0, 5)
RounderAgain.Name = "RounderAgain"
RounderAgain.Parent = Image

InfoImage.Name = "InfoImage"
InfoImage.Parent = Image
InfoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InfoImage.BackgroundTransparency = 1.000
InfoImage.Position = UDim2.new(0.140000001, 0, 0.0799999982, 0)
InfoImage.Size = UDim2.new(0, 30, 0, 30)
InfoImage.Image = "http://www.roblox.com/asset/?id=6031071057"
InfoImage.ImageTransparency = 1.000

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(27, 27, 27)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(36, 36, 36))}
UIGradient_2.Parent = Image

NotificationPositioner.Name = "NotificationPositioner"
NotificationPositioner.Parent = NotificationFrame
NotificationPositioner.SortOrder = Enum.SortOrder.LayoutOrder
NotificationPositioner.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotificationPositioner.Padding = UDim.new(0, 5)

local System = {}

function System.Notify(Text, Duration)
    local transparencyData = {
        ["NotificationText"] = "TextTransparency",
        ["Image"] = "BackgroundTransparency",
        ["InfoImage"] = "ImageTransparency";
    }
    local clonedNotification = Notification:Clone()

    clonedNotification.Parent = NotificationFrame

    spawn(function()
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
    end)

    for i = 1, #Text do
        clonedNotification.NotificationText.Text = string.sub(Text, 1, i)
        game:GetService("RunService").Stepped:wait()
    end

    task.delay(Duration, function()
        spawn(function()
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
        end)

        for i = #Text, 0, -1 do
            clonedNotification.NotificationText.Text = string.sub(Text, 1, i)
            game:GetService("RunService").Stepped:wait()
        end

        Debris:AddItem(clonedNotification, .5)
    end)
end
