#!/usr/bin/env ruby

#//TODO - 
=begin
   ORGANIZE:
      - Add comments for users


   UI:    
     - Port to html
     - Make it interactable and display info better
     - Add images
     - Display additional info - sectors, heart pieces, abilities, items


   DATA:
       - Get additional info - heart pieces, abilities, items
       - Update Progression.json
       - Ignore some enemies + special tweaks
  
      WRONG DATA:
         - nenes-house-interior.cfg should be empty
         - owl in seluded-hut-interiror.cfg
         - nort tower bad index
=end 


require 'victor'
require 'json'




$levels = JSON.parse(File.read("/home/cubeq/Projects/ruby/GetEnemies/ProgressionSorted.json"))
$enemies = JSON.parse(File.read("/home/cubeq/Projects/ruby/GetEnemies/Enemies.json"))


$line_offset = true

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


# This is a scrapped and generally bad branch system. 

# def DrawConnector(svg, x, y)

#     # curve
#     svg.line x1: x, y1: y+50, x2: x+50, y2: y, stroke: 'black'

#     # straight
#     svg.line x1: x+50, y1: y, x2: x+75, y2: y, stroke: 'black'
    
# end
 
def DrawText(svg, x, y, txt)
  svg.text txt, x: x, y: y
end

def DrawImage(svg, x, y, path)
  svg.image href: path, x: x, y: y

end

def main()

    svg = Victor::SVG.new width: 10000, height: 1000, style: { background: '#ddd' }


      for i in 0...$nmb_of_lines do
        multiplier = i
        
        
        # This is a scrapped and generally bad branch system. 

        # if $levels[i][2] == "bonus" then  

        #   draw_upper_line = false 
        #   DrawConnector( svg, (multiplier+1) * $line_shift + 55 , 150)
        #   $index = 50

        # elsif $levels[i][2] == "anyway" then
        #   $index = 0
        # end

        if draw_upper_line then
          DrawLine(svg, $line_shift * (multiplier+1), 200 - $index)
        end

        DrawLine(svg, $line_shift * (multiplier+1), 200)
        

        line_offset_v = 20

        if $line_offset == true then
          line_offset_v = 40
          $line_offset = false
        else
          $line_offset = true
        end
        

        DrawText(svg, $line_shift * (multiplier+1), 100+temp_int, $levels[i][0])        

        k = 0
        
        for j in 0...$enemies.length do

          if $levels[i][0] == $enemies[j][1] then
              DrawImage(svg, $line_shift * (multiplier+1), 210+50*k, "/home/cubeq/Projects/ruby/GetEnemies/svg_generation/image_preparation/img/" + $enemies[j][0] + ".png")
              DrawLine( svg, $line_shift * (multiplier+1), 210+50*k )      
              k = k + 1                 
          end

        end
        
       
        draw_upper_line = true 


        

      end


    svg.save 'output'

end


main()

