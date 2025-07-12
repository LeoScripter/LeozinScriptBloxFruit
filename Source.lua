--[[
GUI idêntica à thumbnail do vídeo (imagem1). 
Design, cores, textos, ícones, botões quadrados, tamanho e posicionamento igual.
Feito para exploits com Drawing API (Hydrogen, Delta, ArceusX).
--]]

local Drawing = Drawing
local gui = {}

-- Fundo escuro, grande, com leve transparência igual ao vídeo
gui.bg = Drawing.new("Quad")
gui.bg.PointA = Vector2.new(0, 0)
gui.bg.PointB = Vector2.new(768, 0)
gui.bg.PointC = Vector2.new(768, 427)
gui.bg.PointD = Vector2.new(0, 427)
gui.bg.Color = Color3.fromRGB(20,20,35)
gui.bg.Filled = true
gui.bg.Transparency = 0.66
gui.bg.Visible = true

-- Título branco grande, inclinado
gui.title = Drawing.new("Text")
gui.title.Position = Vector2.new(85, 45)
gui.title.Text = "PEGA TUDO DO JOGO!!!"
gui.title.Color = Color3.fromRGB(255,255,255)
gui.title.Size = 46
gui.title.Outline = true
gui.title.Center = false
gui.title.Font = 2
gui.title.Visible = true

-- Seta vermelha grossa e curva (simulação)
gui.arrow = Drawing.new("Line")
gui.arrow.From = Vector2.new(260, 65)
gui.arrow.To = Vector2.new(400, 110)
gui.arrow.Color = Color3.fromRGB(255,0,0)
gui.arrow.Thickness = 8
gui.arrow.Visible = true

-- Botão quadrado vermelho do lado direito (simulando Fruit Script)
gui.btnright = Drawing.new("Quad")
gui.btnright.PointA = Vector2.new(670, 45)
gui.btnright.PointB = Vector2.new(730, 45)
gui.btnright.PointC = Vector2.new(730, 105)
gui.btnright.PointD = Vector2.new(670, 105)
gui.btnright.Color = Color3.fromRGB(255,0,40)
gui.btnright.Filled = true
gui.btnright.Transparency = 0.88
gui.btnright.Visible = true

-- Botão quadrado vermelho do lado esquerdo (simulando Fruit Script)
gui.btnleft = Drawing.new("Quad")
gui.btnleft.PointA = Vector2.new(55, 110)
gui.btnleft.PointB = Vector2.new(115, 110)
gui.btnleft.PointC = Vector2.new(115, 170)
gui.btnleft.PointD = Vector2.new(55, 170)
gui.btnleft.Color = Color3.fromRGB(255,0,40)
gui.btnleft.Filled = true
gui.btnleft.Transparency = 0.88
gui.btnleft.Visible = true

-- Ícone/fruta dentro dos botões (simulação com emoji)
gui.btnrighticon = Drawing.new("Text")
gui.btnrighticon.Position = Vector2.new(700, 70)
gui.btnrighticon.Text = "🍎"
gui.btnrighticon.Color = Color3.fromRGB(255,215,0)
gui.btnrighticon.Size = 38
gui.btnrighticon.Center = true
gui.btnrighticon.Outline = true
gui.btnrighticon.Visible = true

gui.btnlefticon = Drawing.new("Text")
gui.btnlefticon.Position = Vector2.new(85, 135)
gui.btnlefticon.Text = "🍎"
gui.btnlefticon.Color = Color3.fromRGB(255,215,0)
gui.btnlefticon.Size = 38
gui.btnlefticon.Center = true
gui.btnlefticon.Outline = true
gui.btnlefticon.Visible = true

-- Texto branco médio, "Weapon", centralizado na parte superior direita
gui.weapon = Drawing.new("Text")
gui.weapon.Position = Vector2.new(500, 80)
gui.weapon.Text = "Weapon"
gui.weapon.Color = Color3.fromRGB(255,255,255)
gui.weapon.Size = 22
gui.weapon.Outline = true
gui.weapon.Center = false
gui.weapon.Font = 2
gui.weapon.Visible = true

-- Texto branco pequeno "Tsuo Hub" no topo, igual thumbnail
gui.hub = Drawing.new("Text")
gui.hub.Position = Vector2.new(90, 85)
gui.hub.Text = "Tsuo Hub"
gui.hub.Color = Color3.fromRGB(255,255,255)
gui.hub.Size = 16
gui.hub.Outline = true
gui.hub.Center = false
gui.hub.Font = 2
gui.hub.Visible = true

-- Texto branco "Race", "Local Player" no canto esquerdo
gui.race = Drawing.new("Text")
gui.race.Position = Vector2.new(90, 190)
gui.race.Text = "Race"
gui.race.Color = Color3.fromRGB(255,255,255)
gui.race.Size = 20
gui.race.Outline = false
gui.race.Center = false
gui.race.Visible = true

gui.localplayer = Drawing.new("Text")
gui.localplayer.Position = Vector2.new(90, 220)
gui.localplayer.Text = "Local Player"
gui.localplayer.Color = Color3.fromRGB(255,255,255)
gui.localplayer.Size = 20
gui.localplayer.Outline = false
gui.localplayer.Center = false
gui.localplayer.Visible = true

-- Texto branco "Select Allowed Rarity" na parte inferior direita
gui.rarity = Drawing.new("Text")
gui.rarity.Position = Vector2.new(500, 340)
gui.rarity.Text = "Select Allowed Rarity"
gui.rarity.Color = Color3.fromRGB(255,255,255)
gui.rarity.Size = 16
gui.rarity.Outline = true
gui.rarity.Center = false
gui.rarity.Font = 2
gui.rarity.Visible = true

-- Texto vermelho grande "UM CLIQUE FARM" com círculo em volta
gui.cliquefarm = Drawing.new("Text")
gui.cliquefarm.Position = Vector2.new(390, 105)
gui.cliquefarm.Text = "UM CLIQUE FARM"
gui.cliquefarm.Color = Color3.fromRGB(255,0,40)
gui.cliquefarm.Size = 26
gui.cliquefarm.Outline = true
gui.cliquefarm.Center = false
gui.cliquefarm.Font = 2
gui.cliquefarm.Visible = true

-- Círculo vermelho ao redor do texto
gui.circle = Drawing.new("Circle")
gui.circle.Position = Vector2.new(505, 125)
gui.circle.Radius = 130
gui.circle.Color = Color3.fromRGB(255,0,40)
gui.circle.Thickness = 4
gui.circle.NumSides = 40
gui.circle.Visible = true

-- Texto verde neon grande "DE GRAÇA mobile e Pc" na parte inferior
gui.degraca = Drawing.new("Text")
gui.degraca.Position = Vector2.new(260, 360)
gui.degraca.Text = "DE GRAÇA mobile e Pc"
gui.degraca.Color = Color3.fromRGB(0,255,40)
gui.degraca.Size = 42
gui.degraca.Outline = true
gui.degraca.Center = false
gui.degraca.Font = 2
gui.degraca.Visible = true

-- Efeito glow/luz branca na lateral inferior
gui.glow = Drawing.new("Line")
gui.glow.From = Vector2.new(20, 427)
gui.glow.To = Vector2.new(730, 427)
gui.glow.Color = Color3.fromRGB(255,255,255)
gui.glow.Thickness = 4
gui.glow.Transparency = 0.5
gui.glow.Visible = true

-- Adicione mais elementos se necessário, mas mantendo absolutamente idêntico à imagem1.
