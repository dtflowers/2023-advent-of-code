### BEGINNING OF PART 1 SOLUTION ####
grid = File.readlines("input.txt").map(&:strip).map(&:chars)

starting_coordinates = grid.map.with_index do |line, i|
  next unless line.include? "S"

  {
    pipe: "S",
    previous_direction: nil,
    steps: 0,
    x: line.index("S"),
    y: i,
    coordinates: "(#{line.index('S')}, #{i})"
  }
end.compact.first

def was_previous_connection?(direction, previous_direction)
  direction == previous_direction
end

def north_connected?(grid, location)
  beginning_is_connected = ["S", "|", "L", "J"].include?(grid[location[:y]][location[:x]])
  end_is_connected = ["|", "F", "7"].include? grid[location[:y] - 1][location[:x]]
  beginning_is_connected && end_is_connected
end

def north_connection(grid, location)
  return unless north_connected?(grid, location)
  return if was_previous_connection?("N", location[:previous_direction])

  {
    pipe: grid[location[:y] - 1][location[:x]],
    previous_direction: "S",
    steps: location[:steps] + 1,
    x: location[:x],
    y: location[:y] - 1,
    coordinates: "(#{location[:x]}, #{location[:y] - 1})"
  }
end

def south_connected?(grid, location)
  beginning_is_connected = ["S", "|", "F", "7"].include? grid[location[:y]][location[:x]]
  end_is_connected = ["|", "L", "J"].include? grid[location[:y] + 1][location[:x]]
  beginning_is_connected && end_is_connected
end

def south_connection(grid, location)
  return unless south_connected?(grid, location)
  return if was_previous_connection?("S", location[:previous_direction])

  {
    pipe: grid[location[:y] + 1][location[:x]],
    previous_direction: "N",
    steps: location[:steps] + 1,
    x: location[:x],
    y: location[:y] + 1,
    coordinates: "(#{location[:x]}, #{location[:y] + 1})"
  }
end

def west_connected?(grid, location)
  beginning_is_connected = ["S", "-", "7", "J"].include? grid[location[:y]][location[:x]]
  end_is_connected = ["-", "F", "L"].include? grid[location[:y]][location[:x] - 1]
  beginning_is_connected && end_is_connected
end

def west_connection(grid, location)
  return unless west_connected?(grid, location)
  return if was_previous_connection?("W", location[:previous_direction])

  {
    pipe: grid[location[:y] + 1][location[:x]],
    previous_direction: "E",
    steps: location[:steps] + 1,
    x: location[:x] - 1,
    y: location[:y],
    coordinates: "(#{location[:x] - 1}, #{location[:y]})"
  }
end

def east_connected?(grid, location)
  beginning_is_connected = ["S", "-", "F", "L"].include?(grid[location[:y]][location[:x]])
  end_is_connected = ["-", "7", "J"].include? grid[location[:y]][location[:x] + 1]
  beginning_is_connected && end_is_connected
end

def east_connection(grid, location)
  return unless east_connected?(grid, location)
  return if was_previous_connection?("E", location[:previous_direction])

  {
    pipe: grid[location[:y]][location[:x] + 1],
    previous_direction: "W",
    steps: location[:steps] + 1,
    x: location[:x] + 1,
    y: location[:y],
    coordinates: "(#{location[:x] + 1}, #{location[:y]})"
  }
end

paths = [east_connection(grid, starting_coordinates),
         north_connection(grid, starting_coordinates),
         south_connection(grid, starting_coordinates),
         west_connection(grid, starting_coordinates)].compact

until (paths.first[:coordinates] == paths.last[:coordinates]) && !paths.first[:previous_direction].nil?
  paths.map! do |path|
    east_connection(grid, path) ||
      north_connection(grid, path) ||
      south_connection(grid, path) ||
      west_connection(grid, path)
  end
end

puts "The solution to part one is #{paths.first[:steps]}"
### END OF PART 1 SOLUTION ####
