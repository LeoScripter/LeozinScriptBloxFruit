local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Diagnóstico: Mensagem no Output
print("Script AzureHub iniciado!")

-- Ícone flutuante
local icon = Instance.new("ImageLabel")
icon.Name = "AzureFloatIcon"
icon.Image = "rbxassetid://6031068424" -- Roblox logo azul (deve aparecer!)
icon.Size = UDim2.new(0,48,0,48)
icon.Position = UDim2.new(0,50,0,100) -- Posição visível
icon.BackgroundTransparency = 1
icon.Parent = LocalPlayer:WaitForChild("PlayerGui")
icon.AnchorPoint = Vector2.new(0.5,0.5)
icon.Active = true

print("Ícone criado. Parent:", icon.Parent)

-- Efeito flutuação
local up = true
RunService.RenderStepped:Connect(function()
    local y = icon.Position.Y.Offset
    if up then
        y = y + 0.5
        if y > 110 then up = false end
    else
        y = y - 0.5
        if y < 90 then up = true end
    end
    icon.Position = UDim2.new(0,50,0,y)
end)

-- GUI principal (oculta inicialmente)
local gui = Instance.new("ScreenGui")
gui.Name = "AzureHub"
gui.Parent = LocalPlayer.PlayerGui
gui.Enabled = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 340)
main.Position = UDim2.new(0.5, -140, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(30, 60, 120)
main.BorderSizePixel = 0
main.Parent = gui
main.AnchorPoint = Vector2.new(0.5,0.5)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundTransparency = 1
title.Text = "W-Azure Mobile Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = main

-- Botão para fechar a GUI
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,32,0,32)
closeBtn.Position = UDim2.new(1,-36,0,4)
closeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.TextColor3 = Color3.new(1,0.4,0.4)
closeBtn.Parent = main

closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
    icon.Visible = true
end)

-- Clique no ícone mostra GUI
icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        gui.Enabled = true
        icon.Visible = false
    end
end)

-- Botão fábrica
function MakeButton(txt, y, fn)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9,0,0,38)
    btn.Position = UDim2.new(0.05,0,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(60, 100, 180)
    btn.Text = txt
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = main
    btn.MouseButton1Click:Connect(fn)
    return btn
end

-- Auto Farm Level
local autofarm = false
local autofarmBtn
local function toggleAutoFarm()
    autofarm = not autofarm
    autofarmBtn.Text = autofarm and "Auto Farm Level: ON" or "Auto Farm Level: OFF"
end

autofarmBtn = MakeButton("Auto Farm Level: OFF", 48, toggleAutoFarm)

-- Função de auto farm (simples, só para testes!)
function FindNearestMob()
    local mobs = workspace:FindFirstChild("Enemies")
    if not mobs then return nil end
    local nearest, dist = nil, math.huge
    for _, mob in pairs(mobs:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local d = (LocalPlayer.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                nearest = mob
            end
        end
    end
    return nearest
end

RunService.RenderStepped:Connect(function()
    if autofarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local mob = FindNearestMob()
        if mob then
            -- Move até o mob
            LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
            -- "Ataca" (apenas em ambiente permitido/teste)
            mob.Humanoid.Health = 0
        end
    end
end)

-- Teleporte rápido
MakeButton("Teleport Starter Island", 96, function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1050, 15, 1200)
end)
MakeButton("Teleport Pirate Village", 144, function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1200, 20, 4500)
end)

-- Auto stats (simulação)
MakeButton("Auto Stat: Melee", 192, function()
    print("Distribuindo pontos em Melee!")
end)

-- GUI arrastável (mobile friendly)
main.Active = true
main.Draggable = true

print("Script AzureHub carregado!")
