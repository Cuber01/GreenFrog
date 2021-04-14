require 'victor'


$levels = {"seaside":[0], "crevice village":[1], "forest":[2, "bonus"], "cave":[3], 
  "dungeon":[4, "anyway"], "castle":[5]}


$nmb_of_lines = $levels.length
$line_shift = 132

def DrawLine(svg, x, y)

  svg.line x1: x,
          y1: y,
          x2: 130+x,
          y2: y,
          stroke: 'black'

end 

def DrawConnector(svg, x, y)

    # curve
    svg.line x1: x, y1: y+50, x2: x+50, y2: y, stroke: 'black'

    # straight
    svg.line x1: x+50, y1: y, x2: x+75, y2: y, stroke: 'black'
    
end


def main()

    svg = Victor::SVG.new width: 1000, height: 1000, style: { background: '#ddd' }


      for i in 1..$nmb_of_lines do
        
        DrawLine(svg, $line_shift*i, 200)

      end

      for i in 1..$nmb_of_lines do

        DrawConnector( svg, i*$line_shift+55 , 150)

      end 




    svg.save 'output'

end


main()

