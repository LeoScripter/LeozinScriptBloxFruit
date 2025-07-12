--[[ 
    Blox Fruits Mobile Farm GUI Script
    Feito por: LeoScripter (Exemplo Educacional)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

-- Função para criar GUI flutuante com ícone
local function createFloatingIcon()
    local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    ScreenGui.Name = "BFarmGUI"
    local IconBtn = Instance.new("ImageButton", ScreenGui)
    IconBtn.Name = "FloatingIcon"
    IconBtn.Image = "rbxassetid://6031094678" -- Ícone padrão Roblox
    IconBtn.Size = UDim2.new(0, 64, 0, 64)
    IconBtn.Position = UDim2.new(0.9, -32, 0.1, 0)
    IconBtn.BackgroundTransparency = 1

    -- Adiciona spinner para arma
    local WeaponLabel = Instance.new("TextLabel", ScreenGui)
    WeaponLabel.Size = UDim2.new(0, 120, 0, 30)
    WeaponLabel.Position = UDim2.new(0.9, -60, 0.18, 0)
    WeaponLabel.Text = "Arma do Farm:"
    WeaponLabel.BackgroundTransparency = 1
    WeaponLabel.TextColor3 = Color3.new(1,1,1)
    local WeaponSpinner = Instance.new("TextButton", ScreenGui)
    WeaponSpinner.Size = UDim2.new(0, 120, 0, 30)
    WeaponSpinner.Position = UDim2.new(0.9, -60, 0.22, 0)
    WeaponSpinner.Text = "Melee"
    WeaponSpinner.BackgroundColor3 = Color3.fromRGB(25,25,25)
    WeaponSpinner.TextColor3 = Color3.new(1,1,1)
    local weaponList = {"Melee", "Sword", "Gun", "Blox Fruit"}
    local weaponIndex = 1
    WeaponSpinner.MouseButton1Click:Connect(function()
        weaponIndex = weaponIndex % #weaponList + 1
        WeaponSpinner.Text = weaponList[weaponIndex]
    end)

    -- Spinner para ilha
    local IslandLabel = Instance.new("TextLabel", ScreenGui)
    IslandLabel.Size = UDim2.new(0, 120, 0, 30)
    IslandLabel.Position = UDim2.new(0.9, -60, 0.28, 0)
    IslandLabel.Text = "Ilha:"
    IslandLabel.BackgroundTransparency = 1
    IslandLabel.TextColor3 = Color3.new(1,1,1)
    local IslandSpinner = Instance.new("TextButton", ScreenGui)
    IslandSpinner.Size = UDim2.new(0, 120, 0, 30)
    IslandSpinner.Position = UDim2.new(0.9, -60, 0.32, 0)
    IslandSpinner.Text = "Starter Island"
    IslandSpinner.BackgroundColor3 = Color3.fromRGB(25,25,25)
    IslandSpinner.TextColor3 = Color3.new(1,1,1)
    local islandList = {"Starter Island", "Pirate Village", "Marine Fortress", "Skylands", "Colosseum", "Magma Village"}
    local islandIndex = 1
    IslandSpinner.MouseButton1Click:Connect(function()
        islandIndex = islandIndex % #islandList + 1
        IslandSpinner.Text = islandList[islandIndex]
    end)

    -- Botão para teleportar
    local TeleportBtn = Instance.new("TextButton", ScreenGui)
    TeleportBtn.Size = UDim2.new(0, 120, 0, 30)
    TeleportBtn.Position = UDim2.new(0.9, -60, 0.38, 0)
    TeleportBtn.Text = "Teleportar"
    TeleportBtn.BackgroundColor3 = Color3.fromRGB(25,90,25)
    TeleportBtn.TextColor3 = Color3.new(1,1,1)
    TeleportBtn.MouseButton1Click:Connect(function()
        teleportToIsland(islandList[islandIndex])
    end)

    -- Botão para trocar de mar
    local SeaBtn = Instance.new("TextButton", ScreenGui)
    SeaBtn.Size = UDim2.new(0, 120, 0, 30)
    SeaBtn.Position = UDim2.new(0.9, -60, 0.44, 0)
    SeaBtn.Text = "Trocar Mar"
    SeaBtn.BackgroundColor3 = Color3.fromRGB(100,25,25)
    SeaBtn.TextColor3 = Color3.new(1,1,1)
    SeaBtn.MouseButton1Click:Connect(function()
        changeSea()
    end)

    -- Botão AutoFarm
    local FarmBtn = Instance.new("TextButton", ScreenGui)
    FarmBtn.Size = UDim2.new(0, 120, 0, 30)
    FarmBtn.Position = UDim2.new(0.9, -60, 0.50, 0)
    FarmBtn.Text = "Auto Farm"
    FarmBtn.BackgroundColor3 = Color3.fromRGB(25,25,90)
    FarmBtn.TextColor3 = Color3.new(1,1,1)
    FarmBtn.MouseButton1Click:Connect(function()
        autoFarmLevel(weaponList[weaponIndex])
    end)

    -- ESP Frutas
    fruitESP()

    -- ESP Jogadores
    playerESP()

    return ScreenGui
end

-- Função de teleportar (exemplo)
function teleportToIsland(islandName)
    -- Encontre a posição da ilha (exemplo, personalize conforme o mapa)
    local islands = {
        ["Starter Island"] = Vector3.new(1077, 16, 1426),
        ["Pirate Village"] = Vector3.new(-1125, 40, 3824),
        ["Marine Fortress"] = Vector3.new(-4363, 195, 1602),
        ["Skylands"] = Vector3.new(-4922, 717, -2624),
        ["Colosseum"] = Vector3.new(-1836, 15, -2732),
        ["Magma Village"] = Vector3.new(-5316, 78, 6009),
    }
    local pos = islands[islandName]
    if pos then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

-- Função para trocar entre mares (Sea 1, 2, 3)
function changeSea()
    local level = LocalPlayer.Data.Level.Value
    local seaReqs = { -- Níveis mínimos por mar
        [1] = 0,
        [2] = 700,
        [3] = 1500
    }
    local currentSea = workspace:FindFirstChild("Sea") and workspace.Sea.Value or 1
    local nextSea = currentSea % 3 + 1
    if level < seaReqs[nextSea] then
        warn("Seu nível é insuficiente para ir ao Mar " .. nextSea)
        -- Exibir erro na tela
        local msg = Instance.new("TextLabel", LocalPlayer.PlayerGui.BFarmGUI)
        msg.Text = "Erro: Nível insuficiente para o Mar " .. nextSea
        msg.Size = UDim2.new(0, 200, 0, 40)
        msg.Position = UDim2.new(0.9, -100, 0.56, 0)
        msg.TextColor3 = Color3.new(1,0,0)
        msg.BackgroundTransparency = 0.3
        delay(3, function() msg:Destroy() end)
        return
    end
    -- Simulação de teleporte entre mares (pode ser diferente no seu jogo)
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, 200, 0))
    -- workspace.Sea.Value = nextSea -- No seu jogo pode precisar mudar algo aqui
end

-- ESP Frutas
function fruitESP()
    for _,v in pairs(workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") and v.Name:match("Fruit") then
            local Billboard = Instance.new("BillboardGui", v.Handle)
            Billboard.Size = UDim2.new(0,100,0,40)
            Billboard.AlwaysOnTop = true
            Billboard.Adornee = v.Handle
            local Txt = Instance.new("TextLabel", Billboard)
            Txt.Size = UDim2.new(1,0,1,0)
            Txt.BackgroundTransparency = 1
            Txt.Text = "🍉 " .. v.Name
            Txt.TextColor3 = Color3.new(1,1,0)
            Txt.TextStrokeTransparency = 0.5
        end
    end
end

-- ESP Jogadores
function playerESP()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local Billboard = Instance.new("BillboardGui", plr.Character.Head)
            Billboard.Size = UDim2.new(0,100,0,40)
            Billboard.AlwaysOnTop = true
            Billboard.Adornee = plr.Character.Head
            local Txt = Instance.new("TextLabel", Billboard)
            Txt.Size = UDim2.new(1,0,1,0)
            Txt.BackgroundTransparency = 1
            Txt.Text = plr.Name
            Txt.TextColor3 = Color3.new(0,1,1)
            Txt.TextStrokeTransparency = 0.5
        end
    end
end

-- Auto Farm Level (voando até o NPC, aceitando quest e matando)
function autoFarmLevel(weaponType)
    local level = LocalPlayer.Data.Level.Value
    local npc, quest
    -- Exemplo: busca NPC do seu level (simulação)
    for _,v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Level.Value <= level then
            npc = v
            break
        end
    end
    if not npc then
        warn("Não há NPC disponível para seu level.")
        return
    end
    -- Aceita quest (simulação)
    local questGiver = workspace:FindFirstChild("QuestGivers") and workspace.QuestGivers:GetChildren()[1]
    if questGiver then
        -- Simula click no quest giver
        fireclickdetector(questGiver.ClickDetector)
    end
    -- Voa até NPC
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local tween = TweenService:Create(hrp, TweenInfo.new(2), {CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0,10,0)})
    tween:Play()
    tween.Completed:Wait()
    -- Simula ataque automático até matar o NPC
    while npc and npc.Humanoid.Health > 0 do
        -- Simula clique/ataque (ajuste conforme sua arma)
        ReplicatedStorage.Remotes.Combat:FireServer(weaponType, npc)
        wait(0.2)
    end
end

-- Inicializar GUI
createFloatingIcon()
