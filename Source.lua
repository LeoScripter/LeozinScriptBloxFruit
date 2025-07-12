--[[
GUI inspirado na thumbnail do vídeo (imagem1), estilo Tsuo Hub para Blox Fruits Mobile.
Foco: efeito neon, botões flutuantes quadrados com ícone, texto destacado branco e verde/vermelho, fundo escuro transparente.
Feito para exploits que suportam Drawing API. Adapte assets conforme necessário.
]]

local Drawing = Drawing
local gui = {}

-- Fundo escuro, efeito blur neon
gui.bg = Drawing.new("Quad")
gui.bg.PointA = Vector2.new(50, 100)
gui.bg.PointB = Vector2.new(470, 100)
gui.bg.PointC = Vector2.new(470, 360)
gui.bg.PointD = Vector2.new(50, 360)
gui.bg.Color = Color3.fromRGB(25,25,40)
gui.bg.Filled = true
gui.bg.Transparency = 0.6
gui.bg.Visible = true

-- Título neon branco
gui.title = Drawing.new("Text")
gui.title.Position = Vector2.new(90, 120)
gui.title.Text = "PEGA TUDO DO JOGO!!!"
gui.title.Color = Color3.fromRGB(255,255,255)
gui.title.Size = 34
gui.title.Outline = true
gui.title.Center = false
gui.title.Font = 2
gui.title.Visible = true

-- Seta vermelha (desenho simples)
gui.arrow = Drawing.new("Line")
gui.arrow.From = Vector2.new(220, 138)
gui.arrow.To = Vector2.new(310, 150)
gui.arrow.Color = Color3.fromRGB(255,0,0)
gui.arrow.Thickness = 5
gui.arrow.Visible = true

-- Texto vermelho grande
gui.redtext = Drawing.new("Text")
gui.redtext.Position = Vector2.new(320, 140)
gui.redtext.Text = "UM CLIQUE FARM"
gui.redtext.Color = Color3.fromRGB(255,40,40)
gui.redtext.Size = 22
gui.redtext.Outline = true
gui.redtext.Center = false
gui.redtext.Font = 2
gui.redtext.Visible = true

-- Botão flutuante com ícone gold (simulando Weapon ou Race)
gui.btn1 = Drawing.new("Quad")
gui.btn1.PointA = Vector2.new(75, 175)
gui.btn1.PointB = Vector2.new(145, 175)
gui.btn1.PointC = Vector2.new(145, 245)
gui.btn1.PointD = Vector2.new(75, 245)
gui.btn1.Color = Color3.fromRGB(255,215,0)
gui.btn1.Filled = true
gui.btn1.Transparency = 0.85
gui.btn1.Visible = true

gui.btn1icon = Drawing.new("Text")
gui.btn1icon.Position = Vector2.new(110, 195)
gui.btn1icon.Text = "⚔️"
gui.btn1icon.Color = Color3.fromRGB(255,140,0)
gui.btn1icon.Size = 40
gui.btn1icon.Center = true
gui.btn1icon.Outline = true
gui.btn1icon.Visible = true

-- Botão flutuante com ícone vermelho (simulando Race)
gui.btn2 = Drawing.new("Quad")
gui.btn2.PointA = Vector2.new(170, 175)
gui.btn2.PointB = Vector2.new(240, 175)
gui.btn2.PointC = Vector2.new(240, 245)
gui.btn2.PointD = Vector2.new(170, 245)
gui.btn2.Color = Color3.fromRGB(255,0,40)
gui.btn2.Filled = true
gui.btn2.Transparency = 0.85
gui.btn2.Visible = true

gui.btn2icon = Drawing.new("Text")
gui.btn2icon.Position = Vector2.new(205, 195)
gui.btn2icon.Text = "👹"
gui.btn2icon.Color = Color3.fromRGB(255,255,255)
gui.btn2icon.Size = 40
gui.btn2icon.Center = true
gui.btn2icon.Outline = true
gui.btn2icon.Visible = true

-- Botão flutuante com ícone verde (simulando Beast)
gui.btn3 = Drawing.new("Quad")
gui.btn3.PointA = Vector2.new(265, 175)
gui.btn3.PointB = Vector2.new(335, 175)
gui.btn3.PointC = Vector2.new(335, 245)
gui.btn3.PointD = Vector2.new(265, 245)
gui.btn3.Color = Color3.fromRGB(40,255,40)
gui.btn3.Filled = true
gui.btn3.Transparency = 0.85
gui.btn3.Visible = true

gui.btn3icon = Drawing.new("Text")
gui.btn3icon.Position = Vector2.new(300, 195)
gui.btn3icon.Text = "🐾"
gui.btn3icon.Color = Color3.fromRGB(255,255,255)
gui.btn3icon.Size = 40
gui.btn3icon.Center = true
gui.btn3icon.Outline = true
gui.btn3icon.Visible = true

-- Texto verde neon destacado
gui.greentext = Drawing.new("Text")
gui.greentext.Position = Vector2.new(90, 275)
gui.greentext.Text = "DE GRAÇA mobile e Pc"
gui.greentext.Color = Color3.fromRGB(40,255,40)
gui.greentext.Size = 28
gui.greentext.Outline = true
gui.greentext.Center = false
gui.greentext.Font = 2
gui.greentext.Visible = true

-- Texto de fundo branco, simulando opções
local options = {
    {txt="Race", pos=Vector2.new(160, 170)},
    {txt="Local Player", pos=Vector2.new(160, 195)},
    {txt="Weapon", pos=Vector2.new(160, 220)},
    {txt="Select Allowed Rarity", pos=Vector2.new(160, 245)},
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

-- Efeito glow extra (simples linhas brancas)
local glow1 = Drawing.new("Line")
glow1.From = Vector2.new(55, 105)
glow1.To = Vector2.new(465, 110)
glow1.Color = Color3.fromRGB(255,255,255)
glow1.Thickness = 2
glow1.Transparency = 0.5
glow1.Visible = true

local glow2 = Drawing.new("Line")
glow2.From = Vector2.new(55, 355)
glow2.To = Vector2.new(465, 355)
glow2.Color = Color3.fromRGB(255,255,255)
glow2.Thickness = 2
glow2.Transparency = 0.5
glow2.Visible = true

-- Personalize mais elementos conforme sua necessidade!
