require 'json'

$progression_raw =  File.read("./Progression.json")
$progression_array = JSON.parse($progression_raw)
$progression_hashtable = {}

$progression_array = $progression_array.sort_by{ |e| e[1] }

$progression_hashtable = $progression_array.to_h

$progression = JSON.dump $progression_hashtable

puts $progression

