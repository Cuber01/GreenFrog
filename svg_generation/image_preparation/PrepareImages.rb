require 'mini_magick'
require 'json'

$enemy_info_raw =  File.read("../../Enemies.json")
$enemy_info = JSON.parse($enemy_info_raw)

=begin
    
$enemy_info[0] = index of enemy
$enemy_info[0][0] = name of enemy
$enemy_info[0][1] = first appearence of enemy
$enemy_info[0][2] = array with rect data
$enemy_info[0][3] = path to the .png file
    
=end

def main()
   
   for i in 0...$enemy_info.length do
        
        EditImage(
            $enemy_info[i][0],
            $enemy_info[i][2][0],
            $enemy_info[i][2][1],
            $enemy_info[i][2][2],
            $enemy_info[i][2][3],
            $enemy_info[i][3]
        )
    
   end 


end

def EditImage(name, up_x, up_y, down_x, down_y, path)
    
    width = down_x - up_x + 1
    height = down_y - up_y 

    image = MiniMagick::Image.open(path)
     
    image.combine_options do |b|   
        
        # crop image
        image.crop "%dx%d+%d+%d" % [width, height, up_x, up_y]
        
        # make background transparent
        image.transparent "rgb(111, 109, 81)"
        image.transparent "rgb(249, 48, 61)"

    end


    image.format "png"
    image.write "img/" + name + ".png"

end

# image.combine_options do |b|   
#   end


main()
