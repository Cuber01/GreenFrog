require 'json'

$enemy_folder = "/home/cubeq/bin/anura/modules/frogatto/data/objects/enemies/"
$level_folder = "/home/cubeq/bin/anura/modules/frogatto/data/level/"
$current_folder = ""

$progression_raw =  File.read("./ProgressionSorted.json")
$progression = JSON.parse($progression_raw)

$enemies = []
$levels = []

def GetEnemyDirs()
    
    directories = Dir.entries($enemy_folder)

    for i in 0...directories.length
        
        if not directories[i].include? "." then 
            $current_folder = $enemy_folder + directories[i]
            GetEnemies($current_folder)
        end

    end

    ExtractIDs()
    
    #puts $enemies
    #puts $progression
end

def GetEnemies(folder)
    folder_contents = Dir.entries(folder)
    
    
    for i in 0...folder_contents.length
        
        if folder_contents[i] != "." and folder_contents[i] != ".." then
           $enemies << folder_contents[i]
        end


    end

end

def ExtractIDs()

    for i in 0...$enemies.length
        $enemies[i] = File.basename($enemies[i], '.cfg')
    end

end


def GetLevelDirs()
    directories = Dir.entries($level_folder)

    for i in 0...directories.length
        
        if not directories[i].include? "." then 
            $current_folder = $level_folder + directories[i] + "/"
            GetLevels($current_folder)
        end

    end

end

def GetLevels(folder)
    folder_contents = Dir.entries(folder)
    

    for i in 0...folder_contents.length
        
        if folder_contents[i] != "." and folder_contents[i] != ".." then
            $levels << folder + folder_contents[i]
        end

    end

    
end

GetLevelDirs()
puts $levels
#GetEnemyDirs()
