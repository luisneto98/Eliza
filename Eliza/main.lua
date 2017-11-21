objects = {}
function love.load()
  world = love.physics.newWorld(0,0,true);
  rDiscPlayer = 20
  rDisc = 10
  widthArena = 700
  widthWall = 10
  heigthArena = 400
  widthGol = 70
  posiXArena = 50
  posiYArena = 50
  power = 4000
  
  
  objects.player1 = {}
  objects.player1.body = love.physics.newBody(world,120,100,"dynamic")
  objects.player1.shape = love.physics.newCircleShape(rDiscPlayer)
  objects.player1.fixture = love.physics.newFixture(objects.player1.body,objects.player1.shape,1)
  objects.player1.fixture:setRestitution(0)
  
  objects.player2 = {}
  objects.player2.body = love.physics.newBody(world,500,200,"dynamic")
  objects.player2.shape = love.physics.newCircleShape(rDiscPlayer)
  objects.player2.fixture = love.physics.newFixture(objects.player2.body,objects.player2.shape,1)
  objects.player2.fixture:setRestitution(0)
  
  objects.disc = {}
  objects.disc.body = love.physics.newBody(world,140,140,"dynamic")
  objects.disc.shape = love.physics.newCircleShape(rDisc)
  objects.disc.fixture = love.physics.newFixture(objects.disc.body,objects.disc.shape,1)
  objects.disc.fixture:setRestitution(1)
  objects.disc.fixture:setUserData("disc")
  isCenter = true
  
  objects.wallDown = {}
  objects.wallDown.body = love.physics.newBody(world,widthArena/2+posiXArena,heigthArena+posiYArena,"static")
  objects.wallDown.shape = love.physics.newRectangleShape(widthArena,widthWall)
  objects.wallDown.fixture = love.physics.newFixture(objects.wallDown.body,objects.wallDown.shape,5)
  
  objects.wallUp = {}
  objects.wallUp.body = love.physics.newBody(world,widthArena/2+posiXArena,posiYArena,"static")
  objects.wallUp.shape = love.physics.newRectangleShape(widthArena,widthWall)
  objects.wallUp.fixture = love.physics.newFixture(objects.wallUp.body,objects.wallUp.shape,5)
  
  objects.wallLeft1 = {}
  objects.wallLeft1.body = love.physics.newBody(world,posiXArena+widthWall/2,(heigthArena-widthGol-widthWall)/4 + posiYArena+widthWall/2,"static")
  objects.wallLeft1.shape = love.physics.newRectangleShape(widthWall,(heigthArena-widthGol-widthWall)/2)
  objects.wallLeft1.fixture = love.physics.newFixture(objects.wallLeft1.body,objects.wallLeft1.shape,5)
  
  objects.wallLeft2 = {}
  objects.wallLeft2.body = love.physics.newBody(world,posiXArena+widthWall/2,(heigthArena-widthGol-widthWall)*3/4 + widthGol + posiYArena+widthWall/2,"static")
  objects.wallLeft2.shape = love.physics.newRectangleShape(widthWall,(heigthArena-widthGol-widthWall)/2)
  objects.wallLeft2.fixture = love.physics.newFixture(objects.wallLeft2.body,objects.wallLeft2.shape,5)
  
  objects.wallLeft3 = {}
  objects.wallLeft3.body = love.physics.newBody(world,posiXArena-10,posiYArena + heigthArena/2,"static")
  objects.wallLeft3.shape = love.physics.newRectangleShape(widthWall,heigthArena)
  objects.wallLeft3.fixture = love.physics.newFixture(objects.wallLeft3.body,objects.wallLeft3.shape,5)
  objects.wallLeft3.fixture:setUserData("wallP1")
  
  objects.wallRigth1 = {}
  objects.wallRigth1.body = love.physics.newBody(world,widthArena+posiXArena-widthWall/2,(heigthArena-widthGol-widthWall)/4 + posiYArena+widthWall/2,"static")
  objects.wallRigth1.shape = love.physics.newRectangleShape(widthWall,(heigthArena-widthGol-widthWall)/2)
  objects.wallRigth1.fixture = love.physics.newFixture(objects.wallRigth1.body,objects.wallRigth1.shape,5)
  
  objects.wallRigth2 = {}
  objects.wallRigth2.body = love.physics.newBody(world,widthArena+posiXArena-widthWall/2,(heigthArena-widthGol-widthWall)*3/4 + widthGol + posiYArena+widthWall/2,"static")
  objects.wallRigth2.shape = love.physics.newRectangleShape(widthWall,(heigthArena-widthGol-widthWall)/2)
  objects.wallRigth2.fixture = love.physics.newFixture(objects.wallRigth2.body,objects.wallRigth2.shape,5)    
    
  objects.wallRigth3 = {}
  objects.wallRigth3.body = love.physics.newBody(world,widthArena+posiXArena+10,posiYArena + heigthArena/2,"static")
  objects.wallRigth3.shape = love.physics.newRectangleShape(widthWall,heigthArena)
  objects.wallRigth3.fixture = love.physics.newFixture(objects.wallRigth3.body,objects.wallRigth3.shape,5)
  objects.wallRigth3.fixture:setUserData("wallP2")
  
  interaction = 0
  scoreP1 = 0
  scoreP2 = 0
  
end
function love.update(dt)
  world:update(dt)
  centerDisc()

  if(objects.player1.body:getX()>widthArena/2+posiXArena) then
    x,y = objects.player1.body:getLinearVelocity()
    objects.player1.body:setLinearVelocity(0,y)
    objects.player1.body:setPosition(widthArena/2+posiXArena,objects.player1.body:getY())
  end
  if(objects.player2.body:getX()<widthArena/2+posiXArena) then
    x,y = objects.player2.body:getLinearVelocity()
    objects.player2.body:setLinearVelocity(0,y)
    objects.player2.body:setPosition(widthArena/2+posiXArena,objects.player2.body:getY())
  end
  
  require ("Translator")
  
  run(loadTableInfo(),1)
  if( getUp() ~= nil and getUp() ~= 0) then
    objects.player1.body:applyForce(0,-power)
  end
  if(getDown() ~= nil and getDown() ~= 0) then
    objects.player1.body:applyForce(0,power)
  end
  if(getLeft() ~= nil and getLeft() ~= 0) then
    objects.player1.body:applyForce(-power,0)
  end
  if(getRight() ~= nil and getRight() ~= 0) then
    objects.player1.body:applyForce(power,0)
  end
    
  
  run(loadTableInfo(),2)
  if(getUp() ~= nil and getUp() ~= 0) then
    objects.player2.body:applyForce(0,-power)
  end
  if(getDown() ~= nil and getDown() ~= 0) then
    objects.player2.body:applyForce(0,power)
  end
  if(getLeft() ~= nil and getLeft() ~= 0) then
    objects.player2.body:applyForce(-power,0)
  end
  if(getRight() ~= nil and getRight() ~= 0) then
    objects.player2.body:applyForce(power,0)
  end
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  interaction = interaction +1
end
function love.draw()
  love.graphics.setColor(0,0,255)
  love.graphics.circle("fill",objects.player1.body:getX(),objects.player1.body:getY(),objects.player1.shape:getRadius())
  love.graphics.circle("fill",objects.player2.body:getX(),objects.player2.body:getY(),objects.player2.shape:getRadius())
  love.graphics.setColor(0,255,0)
  love.graphics.circle("fill",objects.disc.body:getX(),objects.disc.body:getY(),objects.disc.shape:getRadius())
  love.graphics.setColor(255,255,255)
  love.graphics.polygon("fill", objects.wallDown.body:getWorldPoints(objects.wallDown.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallUp.body:getWorldPoints(objects.wallUp.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallLeft1.body:getWorldPoints(objects.wallLeft1.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallLeft2.body:getWorldPoints(objects.wallLeft2.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallRigth1.body:getWorldPoints(objects.wallRigth1.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallRigth2.body:getWorldPoints(objects.wallRigth2.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallRigth3.body:getWorldPoints(objects.wallRigth3.shape:getPoints()))
  love.graphics.polygon("fill", objects.wallLeft3.body:getWorldPoints(objects.wallLeft3.shape:getPoints()))
  love.graphics.print(scoreP1,20,20)
  love.graphics.print(scoreP2,500,20)
  love.graphics.print(widthArena/2+posiXArena,40,20)
end

function beginContact(a, b, coll)
  an = a:getUserData()
  bn = b:getUserData()
  if((an == "wallP1" and bn == "disc") or (bn == "wallP1" and an == "disc")) then
    scoreP2 = scoreP2 + 1
    isCenter = true
  end
  if((an == "wallP2" and bn == "disc") or (bn == "wallP2" and an == "disc")) then
    scoreP1 = scoreP1 + 1
    isCenter = true
  end
 
end
 
function endContact(a, b, coll)
 
end
 
function preSolve(a, b, coll)
 
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 
end

function centerDisc()
  if(isCenter)then
    objects.disc.body:setPosition(posiXArena+widthArena/2,posiYArena+heigthArena/2)
    objects.disc.body:setLinearVelocity(0,0)
    isCenter = false
  end
end
function loadTableInfo()
  gameInfo = {}
  gameInfo.player1 = {}
  gameInfo.player1.posiX = objects.player1.body:getX()-posiXArena-widthWall
  gameInfo.player1.posiY = objects.player1.body:getY()-posiYArena-widthWall
  gameInfo.player1.radius = objects.player1.shape:getRadius()
  
  gameInfo.player2 = {}
  gameInfo.player2.posiX = objects.player2.body:getX()-posiXArena-widthWall
  gameInfo.player2.posiY = objects.player2.body:getY()-posiYArena-widthWall
  gameInfo.player2.radius = objects.player2.shape:getRadius()
  
  gameInfo.disc = {}
  gameInfo.disc.posiX = objects.disc.body:getX()-posiXArena-widthWall
  gameInfo.disc.posiY = objects.disc.body:getY()-posiYArena-widthWall
  gameInfo.disc.radius = objects.disc.shape:getRadius()
  
  gameInfo.arena = {}
  gameInfo.arena.width = widthArena-2*widthWall
  gameInfo.arena.heigth = heigthArena-widthWall
  
  
  return gameInfo
end