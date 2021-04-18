
require 'json'


$enemy_folder = "/home/cubeq/bin/anura/modules/frogatto/data/objects/enemies/"
$level_folder = "/home/cubeq/bin/anura/modules/frogatto/data/level/"
$enemy_prototypes_folder = "/home/cubeq/bin/anura/modules/frogatto/data/object_prototypes/enemies_specialized"
$images_folder = "/home/cubeq/bin/anura/modules/frogatto/images/"

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
  "factory_remover",
  "spore_shooting_plant",
  "mushroom_missile",
  "gazer_boss_manifold",
  "trap_door",
  "pollen_impact_particle",
  "sinusoidal_flier_shooter",
  "moth_bomber_bomb",
]


$encountered_enemies = []
$enemy_prototypes = []
$enemies = []
$levels = []

$enemy_images = []
$first_appearence = []

###   GET ENEMY INFO

# Get directories with enemy.cfg
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

# Get enemy.cfg from enemy directories
def GetEnemies(folder)
    folder_contents = Dir.entries(folder)


    for i in 0...folder_contents.length do

        if folder_contents[i] != "." and folder_contents[i] != ".." and not folder_contents[i].include? ".fson" then
            $enemies << folder_contents[i]
            $enemy_images << [File.basename(folder_contents[i], '.cfg'), 0]
            GetEnemyRects(folder + '/' + folder_contents[i])
            GetEnemyImages(folder + '/' + folder_contents[i])
        end


    end

end

# Delete '.cfg' from enemy.cfg file
def ExtractIDs()

    for i in 0...$enemies.length do
        $enemies[i] = File.basename($enemies[i], '.cfg')
    end

end

# Get the position of enemy sprite on its spritesheet
def GetEnemyRects(enemy)
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

    ## Remove non enemies
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


                for j in 0...$enemy_prototypes.length


                    if File.basename($enemy_prototypes[j], '.cfg') == prototype_data then

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

# Get a list of enemies_specialized prototypes, because they contain some of the sprite info
def GetEnemyPrototypes()

    folder_contents = Dir.entries($enemy_prototypes_folder)

    for i in 0...folder_contents.length do

        if not folder_contents[i] == "." and not folder_contents[i] == ".." then
            $enemy_prototypes << $enemy_prototypes_folder + '/' + folder_contents[i]
        end

    end


end

# Get a list of all enemy spritesheets
def GetEnemyImages(enemy)
    image_raw = ""
    image_data = ""

    File.open enemy do |file|
        image_raw = file.find { |line| line =~ /image: ".*",/ }
    end

    if image_raw != nil then

        image_data = image_raw.split(": ").last.split(",").first
        
        image_data[0] = ""
        image_data[image_data.length-1] = ""
        
        # Remove empty arrays
        $enemy_images = $enemy_images - [[0]]

        for i in 0...$enemy_images.length do

            if File.basename(enemy, '.cfg') == $enemy_images[i][0] then
                $enemy_images[i][2] = $images_folder + image_data
            end

        end
    
    else
        
        image_raw = ""
        prototype_raw = ""


        File.open enemy do |file|

            prototype_raw = file.find { |line| line =~ /prototype: \[".*"\]\,/ }

        end


        prototype_data = prototype_raw.split('[').last.split(']').first.tr('"', '')



        for i in 0...$enemy_prototypes.length

            if File.basename($enemy_prototypes[i], '.cfg') == prototype_data then
                
                File.open $enemy_prototypes[i] do |file|
                    image_raw = file.find { |line| line =~ /image: ".*",/ }
                end


                image_data = image_raw.split(": ").last.split(",").first
                
                image_data[0] = ""
                image_data[image_data.length-1] = ""
               
        
                for j in 0...$enemy_images.length do

                    if File.basename(enemy, '.cfg') == $enemy_images[j][0] then
                        $enemy_images[j][2] = $images_folder + image_data
                    end

                end
    
            end

        end

    end


end

# Get directories with level.cfg
def GetLevelDirs()
    directories = Dir.entries($level_folder)

    for i in 0...directories.length do

        if not directories[i].include? "." then
            $current_folder = $level_folder + directories[i] + "/"
            GetLevels($current_folder)
        end

    end

end

# Get level.cfg files
def GetLevels(folder)
    folder_contents = Dir.entries(folder)


    for i in 0...folder_contents.length do

        if folder_contents[i] != "." and folder_contents[i] != ".." then
            $levels << folder + folder_contents[i]
        end

    end

end

# Call the SearchLevel method on every level
def SelectLevelForSearch()

    for i in 0...$progression.length do

        for j in 0...$levels.length do

            if $progression[i][0] == File.basename($levels[j]) then
                SearchLevel($levels[j])
            end

        end


    end


end

# Delete non enemies (test enemies, enemy missiles, some hazards) from the enemy list
def ExcludeNonEnemies()

    $enemies = $enemies - $non_enemies

    $enemy_images = $enemy_images - [[0]]

end

# Search the level.cfg for enemies
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

def CombineArrays()
 
    for i in 0...$first_appearence.length do
    
        for j in 0...$enemy_images.length do

            if $first_appearence[i][0] == $enemy_images[j][0] then
                $first_appearence[i][2] = $enemy_images[j][1]
                $first_appearence[i][3] = $enemy_images[j][2]
            end

        end 
    
    end

end

def main()

    # Get prototypes of enemies, they will help us in getting some of the data that's not overwritten by the main enemy file
    GetEnemyPrototypes()

    # Get folders with levels 
    GetLevelDirs()

    # Get folders with enemies. This method also contains calls to a few function collecting info about enemies - rects, images 
    GetEnemyDirs()

    # Search through levels and get the first appearence of all enemies
    SelectLevelForSearch()

    # Combine info from SelectLevelForSearch() and methods called in GetEnemyDirs()
    CombineArrays()

    puts $first_appearence.to_s

end

main()