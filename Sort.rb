#!/usr/bin/env ruby

require 'json'

def main()
    progression_raw =  File.read("./Progression.json")
    progression_array = JSON.parse(progression_raw)
    progression_sorted = progression_array.sort_by{ |e| e[1] }

    puts progression_sorted.to_s
end

main()

