table = [ ["a", "b"] , ["c","d"] ]
array = ["a","c"]

dupa = []
table.each do | subtable |
    dupa << ( subtable - array )
end

puts dupa
