function play(data,num)
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