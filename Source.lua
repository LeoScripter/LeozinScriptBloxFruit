-- Versão: 1.0
-- Descrição: Script Mobile Blox Fruits com ESP e GUI flutuante
-- Autor: BlackboxAI

-- Configurações iniciais
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Configurações do ESP
local ESP_ENABLED = true
local ESP_COLOR = Color3.fromRGB(255, 128, 0)
local ESP_TRANSPARENCY = 0.7
local ESP_REFRESH_RATE = 0.5

-- Cria a GUI principal
local MainGUI = Instance.new("ScreenGui")
MainGUI.Name = "BloxFruitsMobileESP"
MainGUI.ResetOnSpawn = false
MainGUI.Parent = CoreGui

-- Ícone flutuante
local FloatingIcon = Instance.new("ImageButton")
FloatingIcon.Name = "FloatingIcon"
FloatingIcon.Image = "rbxassetid://7072771226" -- Ícone genérico de espada
FloatingIcon.ImageColor3 = Color3.fromRGB(255, 128, 0)
FloatingIcon.BackgroundTransparency = 1
FloatingIcon.Size = UDim2.new(0, 50, 0, 50)
FloatingIcon.Position = UDim2.new(0, 20, 0.5, -25)
FloatingIcon.Parent = MainGUI

-- Painel de controle
local ControlPanel = Instance.new("Frame")
ControlPanel.Name = "ControlPanel"
ControlPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ControlPanel.BackgroundTransparency = 0.3
ControlPanel.BorderSizePixel = 2
ControlPanel.BorderColor3 = ESP_COLOR
ControlPanel.Size = UDim2.new(0, 200, 0, 250)
ControlPanel.Position = UDim2.new(1, -220, 0.5, -125)
ControlPanel.Visible = false
ControlPanel.Parent = MainGUI

-- Faz o ícone flutuante arrastável
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    FloatingIcon.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

FloatingIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = FloatingIcon.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatingIcon.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Toggle do painel de controle
FloatingIcon.Activated:Connect(function()
    ControlPanel.Visible = not ControlPanel.Visible
end)

-- Elementos do painel de controle
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "BLOX FRUITS MOBILE"
Title.TextColor3 = ESP_COLOR
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Parent = ControlPanel

local ToggleESPButton = Instance.new("TextButton")
ToggleESPButton.Name = "ToggleESP"
ToggleESPButton.Text = "ESP: ATIVADO"
ToggleESPButton.TextColor3 = Color3.fromRGB(0, 255, 0)
ToggleESPButton.Size = UDim2.new(0.9, 0, 0, 30)
ToggleESPButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleESPButton.Parent = ControlPanel

-- Função ESP
local ESP_Objects = {}

local function createESP(player)
    if player == LocalPlayer then return end
    if not player.Character then return end

    local character = player.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 2)
    if not humanoidRootPart then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name.."_ESP"
    highlight.Adornee = character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Color3.new(0, 0, 0)
    highlight.FillTransparency = 1
    highlight.OutlineColor = ESP_COLOR
    highlight.OutlineTransparency = ESP_TRANSPARENCY
    highlight.Parent = character
    highlight.Enabled = ESP_ENABLED
    
    table.insert(ESP_Objects, {player = player, object = highlight})
    
    -- Tracer
    if character:FindFirstChild("HumanoidRootPart") then
        local tracer = Instance.new("Frame")
        tracer.Name = player.Name.."_Tracer"
        tracer.BackgroundColor3 = ESP_COLOR
        tracer.BorderSizePixel = 0
        tracer.Size = UDim2.new(0, 2, 0, 150)
        tracer.AnchorPoint = Vector2.new(0.5, 1)
        tracer.Parent = MainGUI
        
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                connection:Disconnect()
                tracer:Destroy()
                return
            end
            
            local rootPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(character.HumanoidRootPart.Position)
            if onScreen then
                tracer.Visible = ESP_ENABLED
                tracer.Position = UDim2.new(0, rootPos.X, 0, rootPos.Y)
            else
                tracer.Visible = false
            end
        end)
    end
end

local function removeESP(player)
    for i, espData in pairs(ESP_Objects) do
        if espData.player == player then
            if espData.object and espData.object.Parent then
                espData.object:Destroy()
            end
            table.remove(ESP_Objects, i)
            break
        end
    end
end

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            removeESP(player)
            if player.Character then
                createESP(player)
            end
        end
    end
end

-- Player connection events
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        if ESP_ENABLED then
            createESP(player)
        end
    end)
    
    if player.Character and ESP_ENABLED then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

-- Toggle ESP
ToggleESPButton.MouseButton1Click:Connect(function()
    ESP_ENABLED = not ESP_ENABLED
    if ESP_ENABLED then
        ToggleESPButton.Text = "ESP: ATIVADO"
        ToggleESPButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        updateESP()
    else
        ToggleESPButton.Text = "ESP: DESATIVADO"
        ToggleESPButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        for _, player in pairs(Players:GetPlayers()) do
            removeESP(player)
        end
    end
end)

-- Inicialização
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
        createESP(player)
    end
end
