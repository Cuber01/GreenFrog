require 'mini_magick'


def main()
    up_x = 17
    up_y = 24

    down_x = 124
    down_y = 125

    width = down_x - up_x
    height = down_y - up_y

    image = MiniMagick::Image.open("unknown.png")
    
     
    image.crop "%dx%d+%d+%d" % [width, height, up_x, up_y]
   
    image.format "png"
    image.write "output.png"

end

# image.combine_options do |b|   
#   end


main()
