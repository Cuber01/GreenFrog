require 'victor'



def draw_segment(svg,x,y)
  line_shift = 132


    svg.line x1: x, y1: y+200, x2: x+230, y2: y+150, stroke: 'black'
    svg.line x1: x, y1: y+200, x2: x+230, y2: y+150, stroke: 'black'

    #svg.line x1: line_shift+50, y1: 200, x2: 230, y2: 150, stroke: 'black'
    #svg.line x1: (line_shift+50)*2, y1: 200, x2: 230, y2: 150, stroke: 'black'
    #svg.line x1: 270, y1: 150, x2: 300 y2: 150, stroke: 'black'

end

  



def main()

    levels = {"seaside":0, "crevice village":0, "forest":1, "cave":1, "dungeon":0}


    nmb_of_lines = levels.length
    line_shift = 132

    shift = 92.5

    bonus_start = 1


    svg = Victor::SVG.new width: 1000, height: 1000, style: { background: '#ddd' }

    # svg.build do 
      
      for i in 1..nmb_of_lines do
        
      svg.line  x1: line_shift*i,
         y1: 200,
         x2: 130+line_shift*i,
         y2: 200,
         stroke: 'black'
      end

      for i in 1..nmb_of_lines do

        draw_segment( svg, i*line_shift+50 ,0 )

      end 

    #function()
     
    # end

    svg.save 'output'

end


main()

