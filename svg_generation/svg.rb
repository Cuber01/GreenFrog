#//TODO - 
#
#   ORGANIZE:
#      - Change for to each
#      - Add main()
#      - Add comments for users
#
#
#   UI:
#     - Tag lines as levels  
#     - Make it work with our info       
#     - Display full info about levels
#     - Port to html
#     - Make it interactable and display info better
#     - Add images
#   
#   DATA:
#       - Update Progression.json
#       - It doesnt fully work
#       - Add a way to get images
#       - Ignore some enemies + special tweaks
# 


require 'victor'


$levels = [
  ["seaside", 0, "bonus"],
  ["crevice village", 1],
  ["forest", 2, "anyway"],
  ["cave", 3], 
  ["dungeon", 4, "bonus"],
  ["castle", 5],
  ["cool", 6, "anyway"]
]


$nmb_of_lines = $levels.length
$line_shift = 132

$index = 0

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


      for i in 0...$nmb_of_lines do
        multiplier = i
        #puts multiplier
        
    
        if $levels[i][2] == "bonus" then  

          draw_upper_line = false 
          DrawConnector( svg, (multiplier+1) * $line_shift + 55 , 150)
          $index = 50

        elsif $levels[i][2] == "anyway" then
          $index = 0
        end

        if draw_upper_line then
          DrawLine(svg, $line_shift * (multiplier+1), 200 - $index)
        end

        DrawLine(svg, $line_shift * (multiplier+1), 200)

        draw_upper_line = true 

      end


      # for i in 0...$nmb_of_lines do

      #    #puts $levels[i][2]


      # end




    svg.save 'output'

end


main()

