--require code programmer(player)
local Commands
function run(gamesData,num)
  Commands = {}
  Commands.up = 0
  Commands.down = 0
  Commands.left = 0
  Commands.right = 0
  if(num == 1)then 
    player1(gamesData,num)
  else
    player2(gamesData,num)
  end
end
function player1(data,num)
      if(data.player1.posiY < data.disc.posiY)then
        down(10)
      elseif (data.player1.posiY > data.disc.posiY)then
        up(10)
      end
      if(data.player1.posiX < data.disc.posiX)then
        right(10)
      elseif(data.player1.posiX > data.disc.posiX)then
        left(10)
      end
    
  end
  function player2(data,num)
      if(data.player2.posiY < data.disc.posiY)then
        down(10)
      else
        up(10)
      end
      if(data.player2.posiX < data.disc.posiX)then
        right(10)
      else
        left(10)
      end
    
  end

--function available of the programmer


--functions of move
function up(intensity)
  Commands.up = intensity
end
function getUp()
  return Commands.up
end
function down(intensity)
  Commands.down = intensity
end
function getDown()
    return Commands.down
end
function left(intensity)
  Commands.left = intensity
end
function getLeft()
  return Commands.left
end
function right(intensity)
  Commands.right = intensity
end
function getRight()
    return Commands.right
end