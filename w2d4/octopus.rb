def sluggish_octopus(arr)
  biggest = nil
  arr.each do |el|
    biggest = el if arr.all? {|fish| el.length >= fish.length}
  end
  biggest
end

def dominant_octopus(arr)
  until arr.length == 1
    pivot = arr.shift
    bigger = arr.select {|el| el.length >= pivot.length }
  end
  bigger.first
end

def clever_octopus(arr)
  biggest = ""
  arr.each do |el|
    biggest = el if el.length >= biggest.length
  end
  biggest
end

def slow_dance(dir, arr)
  arr.each_index do |i|
    return i if arr[i] == dir
  end
end

HASH = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "down-left" => 5,
  "left" => 6,
  "left-up" => 7,
}

def constant_dance(dir, hash = HASH)
  hash[dir]
end
