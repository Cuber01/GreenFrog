
# $enemies_who_dont_want_to_cooperate = [
#     ["spider_black"],
#     ["maggot_grey"],
#     ["moth_brown"],
#     ["moth_black"],
#     ["maggot_white"],
#     ["factory_remover"],
#     ["squirrel_red"],
#     ["squirrel_red_alt"],
#     ["squirrel_black"],
#     ["bat_red"],
#     ["bat_black"]
# ]

=begin
heres the plan:
1. if theres no rect
2. find prototype
3. go to prototype and find rect
 
we will need a list of prototypes probablt only from enemies specialized

=end


require 'json'

$enemy_folder = "/home/cubeq/bin/anura/modules/frogatto/data/objects/enemies/"
$level_folder = "/home/cubeq/bin/anura/modules/frogatto/data/level/"
$enemy_prototypes_folder = "/home/cubeq/bin/anura/modules/frogatto/data/object_prototypes/enemies_specialized"

$current_folder = ""

$progression_raw =  File.read("./ProgressionSorted.json")
$progression = JSON.parse($progression_raw)

$non_enemies = [
     "owl",
     "acorn",
     "skeeter_controller",
     "maggot_white_controller",
     "maggot_grey_controller",
     "semiguided_missile",
     "spore_shooting_plant.cfg",
     "spider_silk",
     "factory_remover"]


$encountered_enemies = []
$enemy_prototypes = []
$enemies = []
$levels = []

$enemy_images = []
$first_appearence = []

def GetEnemyDirs()
    
    directories = Dir.entries($enemy_folder)

    for i in 0...directories.length do
        
        if not directories[i].include? "." then 
            $current_folder = $enemy_folder + directories[i]
            GetEnemies($current_folder)
        end

    end

    ExtractIDs()
end

def GetEnemies(folder)
    folder_contents = Dir.entries(folder)
    
    
    for i in 0...folder_contents.length do
        
        if folder_contents[i] != "." and folder_contents[i] != ".." and not folder_contents[i].include? ".fson" then
           $enemies << folder_contents[i]
           $enemy_images << [File.basename(folder_contents[i], '.cfg'), 0]
           GetEnemyImages(folder + '/' + folder_contents[i])
        end


    end

end

def ExtractIDs()

    for i in 0...$enemies.length do
        $enemies[i] = File.basename($enemies[i], '.cfg')
    end

end


def GetEnemyImages(enemy)
    rect_raw = ""    
    
    # Search for rect and get the value 
    File.open enemy do |file|
        rect_raw = file.find { |line| line =~ /rect: \[[0-9]+\,[0-9]+\,[0-9]+\,[0-9]+\]\,/ }
    end

    if rect_raw != nil then 
        rect_data = rect_raw.split("[").last.split("]").first
    else
        rect_data = ""
    end

    ## REMOVE NON ENEMIES
    temp_enemy_images = []

    $enemy_images.each do | subtable |
        temp_enemy_images << ( subtable - $non_enemies )
    end

    $enemy_images = temp_enemy_images
    ##

    for i in 0...$enemy_images.length do

        if File.basename(enemy, '.cfg') == $enemy_images[i][0] then
            
            # If rect was found, add the rect value to the array
            if rect_data != "" then
                $enemy_images[i][1] = rect_data
            else

                # If rect was not found, search for prototype and get rect from prototype
                
                prototype_raw = ""

                File.open enemy do |file|
                    
                    prototype_raw = file.find { |line| line =~ /prototype: \[".*"\]\,/ }
                    
                end

                
                prototype_data = prototype_raw.split('[').last.split(']').first.tr('"', '') 
                #prototype_data = prototype_raw.match(/\".*\"/)
                #prototype_data = prototype_data[1...prototype_data.length()-1]
                


                for j in 0...$enemy_prototypes.length


                    #puts File.basename($enemy_prototypes[j], '.cfg')
                    puts prototype_data


                    if File.basename($enemy_prototypes[j], '.cfg') == prototype_data then
                        puts "HEY"
                        File.open $enemy_prototypes[j] do |file|
                            rect_raw = file.find { |line| line =~ /rect: \[[0-9]+\,[0-9]+\,[0-9]+\,[0-9]+\]\,/ }
                            rect_data = rect_raw.split("[").last.split("]").first

                            $enemy_images[i][1] = rect_data
                        end
                
                    end

                end

            end
                
        
        end


    end

end

def GetEnemyPrototypes()
   
    folder_contents = Dir.entries($enemy_prototypes_folder)

    for i in 0...folder_contents.length do
        
        if not folder_contents[i] == "." and not folder_contents[i] == ".." then 
            $enemy_prototypes << $enemy_prototypes_folder + '/' + folder_contents[i]
        end

    end

   
end





def GetLevelDirs()
    directories = Dir.entries($level_folder)

    for i in 0...directories.length do
        
        if not directories[i].include? "." then 
            $current_folder = $level_folder + directories[i] + "/"
            GetLevels($current_folder)
        end

    end

end

def GetLevels(folder)
    folder_contents = Dir.entries(folder)
    

    for i in 0...folder_contents.length do
        
        if folder_contents[i] != "." and folder_contents[i] != ".." then
            $levels << folder + folder_contents[i]
        end

    end
    
end


def SelectLevelForSearch()
    
    for i in 0...$progression.length do
        
        for j in 0...$levels.length do
            
            if $progression[i][0] == File.basename($levels[j]) then
                SearchLevel($levels[j])
            end

        end
  
        
    end


end

def ExcludeNonEnemies()
    temp_enemy_images = []

    $enemies = $enemies - $non_enemies
    
    $enemy_images.each do | subtable |
        temp_enemy_images << ( subtable - $non_enemies )
    end

    $enemy_images = temp_enemy_images
end

def SearchLevel(level_path)
    
    ExcludeNonEnemies()

    for i in 0...$enemies.length do
       
        if File.read(level_path).include? $enemies[i] then
            $first_appearence << [$enemies[i], File.basename(level_path)] 
            $encountered_enemies << $enemies[i]
        end

    end
    
    
    

    if $encountered_enemies.length > 0 then

        $encountered_enemies.each do |enemy|
            $enemies.delete(enemy)
        end

    end

end

def main()
    
    GetEnemyPrototypes()

    GetLevelDirs()

    GetEnemyDirs()

    SelectLevelForSearch()


    #puts $first_appearence.to_s
   # puts $enemy_images.to_s

end

main()