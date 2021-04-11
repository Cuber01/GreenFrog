require 'json'

$enemy_folder = "/home/cubeq/bin/anura/modules/frogatto/data/objects/enemies/"
$level_folder = "/home/cubeq/bin/anura/modules/frogatto/data/level/"
$current_folder = ""

$progression_raw =  File.read("./Level_Index.json")
$progression = JSON.parse($progression_raw)

$enemies = []

def GetEnemyDirs()
    
    directories = Dir.entries($enemy_folder)

    for i in 0...directories.length
        
        if directories[i] != "." and directories[i] != ".." then 
            $current_folder = $enemy_folder + directories[i]
            GetEnemies($current_folder)
        end

    end

    ExtractIDs()
    
    #puts $enemies
    puts $progression
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


GetEnemyDirs()
