--[[
  Blox Fruits Mobile - Auto Farm & ESP Script (GUI + Floating Icon)
  Features:
    - Floating GUI Icon (no image) to open menu
    - Auto Farm Level: auto quest, auto kill NPC for your level, auto equip selected weapon
    - ESP Fruits on map
    - ESP Players (orange box, tracers, name above box)
    - Spinner (dropdown) to select weapon type: Melee, Sword, Gun, Blox Fruit
  Mobile compatible. Works locally (load from file or executor).
  NOTE: This script is for educational purposes. Use at your own risk.
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

--[[ Services ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

--[[ GUI Creation ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BF_AutoFarmGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Floating Icon
local IconBtn = Instance.new("TextButton")
IconBtn.Size = UDim2.new(0, 50, 0, 50)
IconBtn.Position = UDim2.new(0, 10, 0.5, -25)
IconBtn.Text = "≡"
IconBtn.TextSize = 32
IconBtn.BackgroundColor3 = Color3.fromRGB(255, 136, 0)
IconBtn.TextColor3 = Color3.new(1,1,1)
IconBtn.BorderSizePixel = 0
IconBtn.Draggable = true
IconBtn.Name = "FloatingIcon"
IconBtn.Parent = ScreenGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 270, 0, 320)
MainFrame.Position = UDim2.new(0, 70, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Text = "Blox Fruits Mobile"
Title.TextColor3 = Color3.fromRGB(255, 136, 0)
Title.Parent = MainFrame

local WeaponLabel = Instance.new("TextLabel")
WeaponLabel.Size = UDim2.new(0, 120, 0, 30)
WeaponLabel.Position = UDim2.new(0, 10, 0, 55)
WeaponLabel.BackgroundTransparency = 1
WeaponLabel.Font = Enum.Font.Gotham
WeaponLabel.Text = "Arma para Farm:"
WeaponLabel.TextSize = 17
WeaponLabel.TextColor3 = Color3.new(1,1,1)
WeaponLabel.Parent = MainFrame

-- Spinner (Dropdown)
local Spinner = Instance.new("TextButton")
Spinner.Size = UDim2.new(0, 110, 0, 30)
Spinner.Position = UDim2.new(0, 140, 0, 55)
Spinner.BackgroundColor3 = Color3.fromRGB(40,40,40)
Spinner.TextColor3 = Color3.new(1,1,1)
Spinner.Font = Enum.Font.Gotham
Spinner.TextSize = 16
Spinner.Text = "Melee"
Spinner.Name = "WeaponSpinner"
Spinner.Parent = MainFrame

local WeaponOptions = {"Melee", "Sword", "Gun", "Blox Fruit"}
local WeaponIndex = 1

-- Toggle Buttons
local function makeToggle(y, text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 28)
	btn.Position = UDim2.new(0.05, 0, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.Text = text.." [OFF]"
	btn.Name = text
	btn.Parent = MainFrame
	return btn
end

local AutoFarmBtn = makeToggle(100, "Auto Farm Level")
local ESPFruitBtn = makeToggle(140, "ESP Frutas")
local ESPPlayerBtn = makeToggle(180, "ESP Player")

--[[ Spinner Logic ]]
Spinner.MouseButton1Click:Connect(function()
	WeaponIndex = WeaponIndex % #WeaponOptions + 1
	Spinner.Text = WeaponOptions[WeaponIndex]
end)

--[[ Icon Logic ]]
IconBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

--[[ Toggle Logic ]]
local Enabled = {
	AutoFarm = false,
	ESPFruit = false,
	ESPPlayer = false
}
AutoFarmBtn.MouseButton1Click:Connect(function()
	Enabled.AutoFarm = not Enabled.AutoFarm
	AutoFarmBtn.Text = "Auto Farm Level ["..(Enabled.AutoFarm and "ON" or "OFF").."]"
end)
ESPFruitBtn.MouseButton1Click:Connect(function()
	Enabled.ESPFruit = not Enabled.ESPFruit
	ESPFruitBtn.Text = "ESP Frutas ["..(Enabled.ESPFruit and "ON" or "OFF").."]"
end)
ESPPlayerBtn.MouseButton1Click:Connect(function()
	Enabled.ESPPlayer = not Enabled.ESPPlayer
	ESPPlayerBtn.Text = "ESP Player ["..(Enabled.ESPPlayer and "ON" or "OFF").."]"
end)

--[[ Auto Farm Level ]]
local function getQuestAndNPC()
	-- Reference for main islands and levels
	local level = LocalPlayer.Data.Level.Value
	-- You can extend this table for more islands
	local zones = {
		{Min=1,Max=14, Quest="BanditQuest1", NPC="Bandit", Place="StarterIsland"},
		{Min=15,Max=29, Quest="MonkeyQuest", NPC="Monkey", Place="Jungle"},
		{Min=30,Max=39, Quest="BuggyQuest1", NPC="Pirate", Place="PirateIsland"},
		-- ... Continue as needed
	}
	for _,zone in ipairs(zones) do
		if level>=zone.Min and level<=zone.Max then
			return zone.Quest, zone.NPC, zone.Place
		end
	end
	-- fallback
	return "BanditQuest1", "Bandit", "StarterIsland"
end

local function equipWeapon(selected)
	local Backpack = LocalPlayer.Backpack
	local Char = LocalPlayer.Character
	for _,v in pairs(Backpack:GetChildren()) do
		if selected == "Melee" and v:IsA("Tool") and v.ToolTip == "Melee" then v.Parent = Char
		elseif selected == "Sword" and v:IsA("Tool") and v.ToolTip == "Sword" then v.Parent = Char
		elseif selected == "Gun" and v:IsA("Tool") and v.ToolTip == "Gun" then v.Parent = Char
		elseif selected == "Blox Fruit" and v:IsA("Tool") and v.ToolTip == "Blox Fruit" then v.Parent = Char
		end
	end
end

local function AutoFarmLoop()
	spawn(function()
		while true do
			RunService.RenderStepped:Wait()
			if not Enabled.AutoFarm then continue end
			local questName, npcName, place = getQuestAndNPC()
			-- Accept Quest if not active
			local hasQuest = LocalPlayer.PlayerGui:FindFirstChild("QuestContainer")
			if not hasQuest or not hasQuest.Visible then
				-- Find quest giver and fire prompt
				for _,v in pairs(Workspace.NPCs:GetChildren()) do
					if v.Name:find(questName) and v:FindFirstChild("Head") then
						LocalPlayer.Character.HumanoidRootPart.CFrame = v.Head.CFrame + Vector3.new(0,2,0)
						wait(1)
						ReplicatedStorage.Remotes.Comm:InvokeServer("StartQuest", questName, 1)
						break
					end
				end
			end
			-- Equip weapon
			equipWeapon(WeaponOptions[WeaponIndex])
			-- Find target NPCs
			for _,v in pairs(Workspace.Enemies:GetChildren()) do
				if v.Name == npcName and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					repeat
						RunService.RenderStepped:Wait()
						if not Enabled.AutoFarm then break end
						LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
						-- Attack
						local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
						if tool then tool:Activate() end
					until v.Humanoid.Health<=0 or not Enabled.AutoFarm
				end
			end
		end
	end)
end

--[[ ESP Fruits ]]
local FruitESP_Boxes = {}
local function ESPFruitLoop()
	spawn(function()
		while true do
			wait(1)
			if not Enabled.ESPFruit then
				for _,b in pairs(FruitESP_Boxes) do b:Destroy() end
				FruitESP_Boxes = {}
				continue 
			end
			for _,obj in pairs(Workspace:GetChildren()) do
				if obj:IsA("Tool") and obj.ToolTip == "Blox Fruit" and not FruitESP_Boxes[obj] then
					local box = Instance.new("BillboardGui")
					box.Adornee = obj.Handle
					box.Size = UDim2.new(0, 80, 0, 20)
					box.AlwaysOnTop = true
					box.Parent = ScreenGui
					local label = Instance.new("TextLabel", box)
					label.Size = UDim2.new(1,0,1,0)
					label.BackgroundTransparency = 1
					label.Text = "🍏 "..obj.Name
					label.TextColor3 = Color3.fromRGB(255, 136, 0)
					label.TextScaled = true
					FruitESP_Boxes[obj] = box
				end
			end
			-- Remove missing fruits
			for obj,box in pairs(FruitESP_Boxes) do
				if not obj or not obj.Parent then box:Destroy() FruitESP_Boxes[obj]=nil end
			end
		end
	end)
end

--[[ ESP Player (Tracer, Box, Name) ]]
local TracerFolder = Instance.new("Folder")
TracerFolder.Name = "TracerFolder"
TracerFolder.Parent = ScreenGui

local function drawBox(plr)
	local char = plr.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = char:FindFirstChild("HumanoidRootPart")
	box.Size = Vector3.new(4,7,3)
	box.Color3 = Color3.fromRGB(255,136,0)
	box.Transparency = 0.5
	box.AlwaysOnTop = true
	box.ZIndex = 10
	box.Parent = TracerFolder
	return box
end
local function drawTracer(plr)
	local char = plr.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local line = Drawing.new("Line")
	line.Color = Color3.fromRGB(255,136,0)
	line.Thickness = 2
	line.Transparency = 0.9
	line.Visible = true
	return line
end
local function drawName(plr)
	local char = plr.Character
	if not char or not char:FindFirstChild("Head") then return end
	local gui = Instance.new("BillboardGui")
	gui.Adornee = char.Head
	gui.Size = UDim2.new(0,120,0,20)
	gui.AlwaysOnTop = true
	gui.Parent = TracerFolder
	local label = Instance.new("TextLabel", gui)
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = plr.Name
	label.TextColor3 = Color3.fromRGB(255,136,0)
	label.TextScaled = true
	return gui
end

local ESPObjects = {}
local function PlayerESP_Loop()
	spawn(function()
		while true do
			RunService.RenderStepped:Wait()
			if not Enabled.ESPPlayer then
				for _,v in pairs(ESPObjects) do
					if v.Box then v.Box:Destroy() end
					if v.Tracer then v.Tracer:Remove() end
					if v.Name then v.Name:Destroy() end
				end
				ESPObjects = {}
				continue
			end
			for _,plr in pairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					if not ESPObjects[plr] then
						ESPObjects[plr] = {
							Box = drawBox(plr),
							Tracer = drawTracer(plr),
							Name = drawName(plr)
						}
					end
					-- Update tracer position (Screen)
					local root = plr.Character:FindFirstChild("HumanoidRootPart")
					if ESPObjects[plr].Tracer and root then
						local pos,vis = Workspace.CurrentCamera:WorldToViewportPoint(root.Position)
						local myPos = Workspace.CurrentCamera.ViewportSize/2
						ESPObjects[plr].Tracer.From = Vector2.new(myPos.X, Workspace.CurrentCamera.ViewportSize.Y)
						ESPObjects[plr].Tracer.To = Vector2.new(pos.X, pos.Y)
						ESPObjects[plr].Tracer.Visible = vis
					end
				end
			end
			-- Remove missing players
			for plr,v in pairs(ESPObjects) do
				if not plr or not plr.Character or not plr.Character.Parent then
					if v.Box then v.Box:Destroy() end
					if v.Tracer then v.Tracer:Remove() end
					if v.Name then v.Name:Destroy() end
					ESPObjects[plr]=nil
				end
			end
		end
	end)
end

--[[ Start Loops ]]
AutoFarmLoop()
ESPFruitLoop()
PlayerESP_Loop()

--[[ End ]]
