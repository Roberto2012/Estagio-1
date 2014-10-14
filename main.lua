print("height: ", display.contentHeight)
print("Width: ", display.contentWidth)
-- Set Variables
motionx = 0; -- Variable used to move character along x axis
speed = 2; -- Set Walking Speed
local width = display.contentWidth; -- Get the width of the screen
local height = display.contentHeight; -- Get the height of the screen
scrollSpeed = 2; -- Set Scroll Speed of background
local vidas = 3;
tick = 2000
local posX = {55, 75}

-- add background image
local bg1 = display.newImage("background2.jpg", width/2, 222);

--add background2 image
local bg2 = display.newImage("background2.jpg", width/2, -269);

--add background3 image
--local bg3 = display.newImage("background2.jpg", width/2,-494);

local function move(event)

-- move backgrounds to the left by scrollSpeed, default is 8
bg1.y = bg1.y + scrollSpeed
bg2.y = bg2.y + scrollSpeed
--bg3.y = bg3.y + scrollSpeed
 
-- Set up listeners so when backgrounds hits a certain point off the screen,
-- move the background to the right off screen

if(bg1.y > 720) then
bg1.x =  width/2
bg1.y = -300
end
if(bg1.y == 720) then
bg1.x =  width/2
bg1.y = -300
end

--while(bg2.y > 720) do 
--bg2.x =  width/2
--bg2.y = -269
--end
--if(bg3.y > 1040) then 
--bg3.x =  width/2 -100
--bg3.y = -600
--end


--[[while((bg2.y + bg2.contentWidth) > 1040) 
do
bg2:translate( 0, width/2 )
end]]
--if (bg3.y + bg3.contentWidth) > 1040 then
--bg3:translate( 0, width/2 )
--end
end
 
-- Create a runtime event to move backgrounds
Runtime:addEventListener( "enterFrame", move )

--Hide status bar from the beginning
display.setStatusBar( display.HiddenStatusBar )
 
-- Start Physics
local physics = require("physics")
physics.start()
physics.setGravity(0, 4)
--physics.setDrawMode( "hybrid" )
 
-- Add busao
local bus = display.newImage( "sprites/busao2.jpg")
bus.x = display.contentWidth/2
bus.y = display.contentHeight -85
physics.addBody( bus, "kinematic")

--Add barra
local quadrado = display.newRect(0, 500, 650, 50)
quadrado.y = display.contentHeight +20
quadrado:setFillColor(0, 50, 140)

-- Add botaoDireita
local botaoDireita = display.newImage("sprites/setaDireita.png")
botaoDireita.x = display.contentWidth -30
botaoDireita.y = display.contentHeight +20

-- Add botaoEsquerda
local botaoEsquerda = display.newImage("sprites/setaEsquerda.png")
botaoEsquerda.x = display.contentWidth -300
botaoEsquerda.y = display.contentHeight +20

--Add 
local texto = display.newText("School Bus Race", 150, 500, nill, 28)

--Exibe vida e pontuacao
local function newText()
	mostrarVidas = display.newText("Vidas: "..vidas, width-50, -20, nil, 28)
end

local function updateText()
	mostrarVidas.text = "Vidas: "..vidas
end

-- When left arrow is touched, move character left
function botaoEsquerda:touch()
motionx = -speed;
end
botaoEsquerda:addEventListener("touch",botaoEsquerda)
-- When right arrow is touched, move character right
function botaoDireita:touch()
motionx = speed;
end
botaoDireita:addEventListener("touch",botaoDireita)

-- Move character
local function moveguy (event)
bus.x = bus.x + motionx;
if(bus.x > width - 30) then
bus.x = width - 30;	
end 
if(bus.x <  width/2  - 130) then
bus.x = width/2  - 130;	
end
end
Runtime:addEventListener("enterFrame", moveguy)

-- Stop character movement when no arrow is pushed
local function stop (event)
if event.phase =="ended" then
motionx = 0;
end
end
Runtime:addEventListener("touch", stop )

-- Criando transito

local function transito()

local z = posX[math.floor (math.random()*3) + 1]
local transito = display.newRect(25, -20, 40, 50)
transito.x = 25 + z
if(transito.x > width - 30) then
transito.x = width - 30;	
end 
if(transito.x <  width/2  - 130) then
transito.x = width/2  - 130;	
end
quadrado:setFillColor(0, 50, 140)
physics.addBody( transito, "dynamic")

end

--Colisao
local function onCollision(event)
    if ( vidas == 1) then
		event.bus:removeSelf()
		vidas = vidas - 1	
	else
		vidas = vidas - 1
	end
end
Runtime:addEventListener("collision", onCollision)
timer.performWithDelay(tick, transito, 0)