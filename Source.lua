--[[
GUI idêntica à parte roxa da thumbnail do vídeo do Tsuo.
Só a área roxa translúcida com textos brancos, botões, e destaque igual ao vídeo.
Feito para exploits mobile com Drawing API (ArceusX, Hydrogen, Delta, etc).
]]

local Drawing = Drawing
local gui = {}

-- FUNDO ROXO translúcido, centralizado
gui.bg = Drawing.new("Quad")
gui.bg.PointA = Vector2.new(60, 90)
gui.bg.PointB = Vector2.new(700, 90)
gui.bg.PointC = Vector2.new(700, 280)
gui.bg.PointD = Vector2.new(60, 280)
gui.bg.Color = Color3.fromRGB(80,40,140)
gui.bg.Filled = true
gui.bg.Transparency = 0.42
gui.bg.Visible = true

-- TÍTULO branco grande
gui.title = Drawing.new("Text")
gui.title.Position = Vector2.new(100, 110)
gui.title.Text = "PEGA TUDO DO JOGO!!!"
gui.title.Color = Color3.fromRGB(255,255,255)
gui.title.Size = 38
gui.title.Outline = true
gui.title.Center = false
gui.title.Font = 2
gui.title.Visible = true

-- Texto branco médio "Tsuo Hub"
gui.hub = Drawing.new("Text")
gui.hub.Position = Vector2.new(100, 140)
gui.hub.Text = "Tsuo Hub"
gui.hub.Color = Color3.fromRGB(255,255,255)
gui.hub.Size = 20
gui.hub.Outline = true
gui.hub.Center = false
gui.hub.Font = 2
gui.hub.Visible = true

-- Texto branco "Weapon"
gui.weapon = Drawing.new("Text")
gui.weapon.Position = Vector2.new(500, 140)
gui.weapon.Text = "Weapon"
gui.weapon.Color = Color3.fromRGB(255,255,255)
gui.weapon.Size = 22
gui.weapon.Outline = true
gui.weapon.Center = false
gui.weapon.Font = 2
gui.weapon.Visible = true

-- Texto branco pequeno "UM CLIQUE FARM" (destaque)
gui.cliquefarm = Drawing.new("Text")
gui.cliquefarm.Position = Vector2.new(500, 170)
gui.cliquefarm.Text = "UM CLIQUE FARM"
gui.cliquefarm.Color = Color3.fromRGB(255,255,255)
gui.cliquefarm.Size = 18
gui.cliquefarm.Outline = true
gui.cliquefarm.Center = false
gui.cliquefarm.Font = 2
gui.cliquefarm.Visible = true

-- Outros textos brancos (simulando opções)
local options = {
    {txt="Race", pos=Vector2.new(100, 170)},
    {txt="Local Player", pos=Vector2.new(100, 200)},
    {txt="Select Allowed Rarity", pos=Vector2.new(500, 200)},
}
for _,v in ipairs(options) do
    local t = Drawing.new("Text")
    t.Position = v.pos
    t.Text = v.txt
    t.Color = Color3.fromRGB(255,255,255)
    t.Size = 16
    t.Outline = false
    t.Center = false
    t.Visible = true
end

-- Nenhum outro elemento além da área roxa e textos, igual à thumbnail.
