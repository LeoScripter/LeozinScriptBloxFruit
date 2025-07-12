--[[
 Blox Fruits Mobile Hub - Estilo W-Azure Hub
 Feito para uso local/testes.
 By LeoScripter
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitsHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Blox Fruits Mobile Hub"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

-- Button Factory
function MakeButton(name, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 120)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = MainFrame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Funções do Hub

-- Teleport para ilhas principais (exemplo)
function TeleportIsland(islandPos)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(islandPos)
    end
end

-- Auto Farm simples (elimina inimigos próximos)
local AutoFarm = false
function ToggleAutoFarm()
    AutoFarm = not AutoFarm
end

RunService.RenderStepped:Connect(function()
    if AutoFarm then
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
                mob.Humanoid.Health = 0 -- Simulando ataque (não funciona em servidores oficiais)
            end
        end
    end
end)

-- Auto Stats (distribui pontos automaticamente)
function AutoStat(statName)
    -- Simulação, pois só funciona em ambientes customizados
    print("Distribuindo pontos para: " .. statName)
    -- Adicione aqui a manipulação real dos stats se disponível
end

-- Lista de teleports (exemplo de posições)
local islands = {
    ["Starter Island"] = Vector3.new(1050, 15, 1200),
    ["Middle Town"] = Vector3.new(-400, 50, 1200),
    ["Pirate Village"] = Vector3.new(-1200, 20, 4500),
}

-- UI Buttons
local y = 50
for island, pos in pairs(islands) do
    MakeButton("Teleport: "..island, y, function() TeleportIsland(pos) end)
    y = y + 40
end

MakeButton("Auto Farm (On/Off)", y, ToggleAutoFarm)
y = y + 40

MakeButton("Auto Stat: Melee", y, function() AutoStat("Melee") end)
y = y + 40
MakeButton("Auto Stat: Defense", y, function() AutoStat("Defense") end)
y = y + 40
MakeButton("Auto Stat: Sword", y, function() AutoStat("Sword") end)

-- Fechar/abrir Hub
local Open = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Open = not Open
        MainFrame.Visible = Open
    end
end)

-- Fim do Script
