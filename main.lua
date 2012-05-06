display.setStatusBar( display.HiddenStatusBar );
local physics = require( "physics" )
physics.start()
system.setAccelerometerInterval( 50 )


local bg = display.newImage( "bg.png" )
bg.x = 480; bg.y = 320;


local text = display.newText("Kilr0y", 40,35,"Helvetica",22)
text:setTextColor(255)

local score = 0
local scoreLabel = display.newText( score, 0, 0, native.systemFontBold, 120 )
scoreLabel.x = display.viewableContentWidth / 2
scoreLabel.y = display.viewableContentHeight / 2
scoreLabel:setTextColor( 0, 0, 0, 10 ) 

local ground = display.newImage( "plataformaBase.png" )
ground.x = 550; ground.y = 500; ground.rotation = 0;
physics.addBody( ground, "static", { friction=1, density=1; bounce=0} )

local pj = display.newImage( "kilr0y.png" )
pj.x = 500; pj.y = 0; pj.rotation = 0.3

physics.addBody( pj, { density=1, friction=1, bounce=0.3, radius=75} )
pj.isFixedRotation = true

local function saltarTocando (event)
  if event.phase == "began" then
    --Saltar
    pj:applyForce(500, -6000, pj.x, pj.y)
  end
  return true
end
Runtime:addEventListener("touch", saltarTocando)

--Mover al personaje con el acelerómetro
local ceil = math.ceil
local pi = math.pi
local atan2 = math.atan2
local playerRotation
-- Set up the Accelerometer values in Landscape

    local motionX = 0
    local motionY = 0 

    local function onAccelerate( event )
          motionX = 5 * event.yGravity;
          motionY = 5 * event.xGravity;

          -- Should I put the rotation here or down in the movePlayer function?

          pj.rotation = playerRotate(event.yGravity, event.xGravity);
    end

    Runtime:addEventListener ("accelerometer", onAccelerate);

 -- Make the player move on tilt.
    function movePlayer (event)

         pj.x = pj.x + motionX
         pj.y = pj.y + motionY
    end
    Runtime:addEventListener("enterFrame", movePlayer)