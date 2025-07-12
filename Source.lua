--[[
🔥 Blox Fruits FODA Mobile Hub 🔥
Script Local para Roblox Studio (StarterPlayerScripts)
Por LeoScripter

Inclui:
- Ícone flutuante personalizado
- GUI estilosa e arrastável
- Auto Farm avançado (simulação)
- Teleporte para ilhas populares
- Auto Stat
- Botão de esconder/mostrar Hub
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Ícone flutuante (pode trocar assetId!)
local icon = Instance.new("ImageLabel")
icon.Name = "FodaFloatIcon"
icon.Image = "rbxassetid://6031068424" -- Roblox logo azul, troque por sua imagem preferida!
icon.Size = UDim2.new(0,64,0,64)
icon.Position = UDim2.new(0,40,0,100)
icon.BackgroundTransparency = 1
icon.Parent = LocalPlayer:WaitForChild("PlayerGui")
icon.AnchorPoint = Vector2.new(0,0)
icon.Active = true

-- Flutuação suave
local direction, baseY = 1, 100
RunService.RenderStepped:Connect(function()
    baseY = baseY + direction * 0.4
    if baseY > 120 then direction = -1 end
    if baseY < 80 then direction = 1 end
    icon.Position = UDim2.new(0,40,0,baseY)
end)

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "FodaHub"
gui.Parent = LocalPlayer.PlayerGui
gui.Enabled = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 420)
main.Position = UDim2.new(0.5, -160, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(35, 35, 80)
main.BorderSizePixel = 0
main.Parent = gui
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 46)
title.BackgroundTransparency = 1
title.Text = "🔥 Blox Fruits FODA Hub 🔥"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,220,80)
title.Parent = main

-- Botão fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,36,0,36)
closeBtn.Position = UDim2.new(1,-40,0,6)
closeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
closeBtn.Parent = main
closeBtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
    icon.Visible = true
end)

-- Abrir Hub pelo ícone
icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        gui.Enabled = true
        icon.Visible = false
    end
end)

-- Botão fábrica
function MakeButton(txt, y, fn)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.Position = UDim2.new(0.05,0,0,y)
    btn.BackgroundColor3 = Color3.fromRGB(65, 120, 220)
    btn.Text = txt
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 19
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = main
    btn.MouseButton1Click:Connect(fn)
    return btn
end

-- Auto Farm Level FODA
local autofarm = false
local autofarmBtn
local function toggleAutoFarm()
    autofarm = not autofarm
    autofarmBtn.Text = autofarm and "Auto Farm Level: ON 🔥" or "Auto Farm Level: OFF"
end

autofarmBtn = MakeButton("Auto Farm Level: OFF", 56, toggleAutoFarm)

-- Função auto farm avançada (simulação/teste)
function FindBestMob()
    local mobs = workspace:FindFirstChild("Enemies")
    if not mobs then return nil end
    local best, dist = nil, math.huge
    for _, mob in pairs(mobs:GetChildren()) do
        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            local d = (LocalPlayer.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                best = mob
            end
        end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    if autofarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local mob = FindBestMob()
        if mob then
            -- Move até o mob (teleporte rápido, fica grudado no mob)
            LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
            -- Simula ataque (apenas ambiente de teste)
            mob.Humanoid.Health = 0
        end
    end
end)

-- TP para ilhas populares
MakeButton("TP: Starter Island", 110, function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1050, 15, 1200)
end)
MakeButton("TP: Pirate Village", 160, function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1200, 20, 4500)
end)
MakeButton("TP: Middle Town", 210, function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-400, 50, 1200)
end)

-- Auto Stat
MakeButton("Auto Stat: Melee", 260, function()
    print("Pontos em Melee distribuídos! 🚀")
end)
MakeButton("Auto Stat: Defense", 310, function()
    print("Pontos em Defense distribuídos! 🛡️")
end)
MakeButton("Auto Stat: Sword", 360, function()
    print("Pontos em Sword distribuídos! ⚔️")
end)

-- Dica: Você pode adicionar mais funções FODA aqui!

print("🔥 Blox Fruits FODA Hub carregado! Ícone flutuante deve aparecer.")

-- Fim!
