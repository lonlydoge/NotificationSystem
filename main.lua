local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

if game:GetService("CoreGui"):FindFirstChild("NotificationUI") then
    game:GetService("CoreGui"):FindFirstChild("NotificationUI"):Destroy();
end

if ReplicatedStorage:FindFirstChild("LocalStorage") then
    ReplicatedStorage:FindFirstChild("LocalStorage"):Destroy();
end

local System = {}

local TransparencyValues = {
    ["UIStroke"] = "Transparency",
    ["Accept"] = "TextTransparency",
    ["Description"] = "TextTransparency",
    ["Title"] = "TextTransparency",
    ["Icon"] = "ImageTransparency",
}

local LocalStorage = Instance.new("Folder", ReplicatedStorage);
LocalStorage.Name = "LocalStorage";

local UI = InsertService:LoadLocalAsset("rbxassetid://9637478938"):Clone();

local Notification = UI.NotificationFrame.Notification;
local BooleanNotification = UI.NotificationFrame.BooleanNotification;

Notification.Parent = LocalStorage
BooleanNotification.Parent = LocalStorage

for _, v in ipairs(Notification:GetDescendants()) do
    if TransparencyValues[v.Name] then
        v[TransparencyValues[v.Name]] = 1;
    end
end

for _, v in ipairs(BooleanNotification:GetDescendants()) do
    if TransparencyValues[v.Name] then
        v[TransparencyValues[v.Name]] = 1;
    end
end

UI.Parent = game:GetService("CoreGui")

System.Notify = function(Title, Text, Duration)
    local ClonedNotification = Notification:Clone();

    ClonedNotification.Parent = UI.NotificationFrame;

    ClonedNotification.Title.Text = Title;
    ClonedNotification.Description.Text = Text;

    local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.5), {
        BackgroundTransparency = 0;
    });

    FrameTween:Play();

    for _, v in pairs(ClonedNotification:GetDescendants()) do
        if TransparencyValues[v.Name] then
            local Tween = TweenService:Create(v, TweenInfo.new(0.5), {
                [TransparencyValues[v.Name]] = 0;
            });
        
            Tween:Play();
        end
    end

    task.delay(Duration, function()
        local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.5), {
            BackgroundTransparency = 1;
        });

        FrameTween:Play();

        for _, v in pairs(ClonedNotification:GetDescendants()) do
            if TransparencyValues[v.Name] then
                local Tween = TweenService:Create(v, TweenInfo.new(0.5), {
                    [TransparencyValues[v.Name]] = 1;
                });
            
                Tween:Play();
            end
        end

        task.delay(0.5, function()
            ClonedNotification:Destroy();
        end);
    end);
end

System.BooleanNotify = function(Title, Text, Duration)
    local Pressed = false;
    local PassedTime = tick();

    local ClonedNotification = BooleanNotification:Clone();

    ClonedNotification.Parent = UI.NotificationFrame;

    ClonedNotification.Title.Text = Title;
    ClonedNotification.Description.Text = Text;

    local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.5), {
        BackgroundTransparency = 0;
    });

    FrameTween:Play();

    for _, v in pairs(ClonedNotification:GetDescendants()) do
        if TransparencyValues[v.Name] then
            local Tween = TweenService:Create(v, TweenInfo.new(0.5), {
                [TransparencyValues[v.Name]] = 0;
            });
        
            Tween:Play();
        end
    end

    local Keybind = UIS.InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == Enum.KeyCode.Y and not gameProcessedEvent then
            local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.5), {
                BackgroundTransparency = 1;
            });
    
            FrameTween:Play();
    
            for _, v in pairs(ClonedNotification:GetDescendants()) do
                if TransparencyValues[v.Name] then
                    local Tween = TweenService:Create(v, TweenInfo.new(0.5), {
                        [TransparencyValues[v.Name]] = 1;
                    });
                
                    Tween:Play();
                end
            end
    
            task.delay(0.5, function()
                ClonedNotification:Destroy();
            end);

            Pressed = true;
            return
        end
    end)

    repeat game:GetService("RunService").RenderStepped:wait() until math.round(tick() - PassedTime, 2) >= Duration or Pressed;

    if Pressed then
        return true;
    end

    local FrameTween = TweenService:Create(ClonedNotification, TweenInfo.new(0.5), {
        BackgroundTransparency = 1;
    });

    FrameTween:Play();

    for _, v in pairs(ClonedNotification:GetDescendants()) do
        if TransparencyValues[v.Name] then
            local Tween = TweenService:Create(v, TweenInfo.new(0.5), {
                [TransparencyValues[v.Name]] = 1;
            });
        
            Tween:Play();
        end
    end

    task.delay(0.5, function()
        ClonedNotification:Destroy();
    end);

    return false
end

return System;
