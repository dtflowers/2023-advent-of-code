### BEGINNING OF PART 1 SOLUTION ####
input = File.readlines("input.txt")

maximum_blues = 14
maximum_greens = 13
maximum_reds = 12

sum = input.each.map do |game|
  most_blues = 0
  most_greens = 0
  most_reds = 0

  results = game.split(": ").last.split("; ")

  results.each do |result|
    cubes = result.strip.split(", ")
    cubes.each do |cube|
      quantity = cube.split.first.to_i
      color = cube.split.last
      case color
      when "blue"
        most_blues = quantity if quantity > most_blues
      when "green"
        most_greens = quantity if quantity > most_greens
      when "red"
        most_reds = quantity if quantity > most_reds
      end
    end
  end

  impossible = most_blues > maximum_blues || most_greens > maximum_greens || most_reds > maximum_reds

  if impossible
    0
  else
    game.split(": ").first.split.last.to_i
  end
end.sum

puts "The solution to part one of the challenge is #{sum}."
### END OF PART 1 SOLUTION ####

### BEGINNING OF PART 2 SOLUTION ####
sum = input.each.map do |game|
  minimum_blues = 0
  minimum_greens = 0
  minimum_reds = 0

  results = game.split(": ").last.split("; ")

  results.each do |result|
    cubes = result.strip.split(", ")
    cubes.each do |cube|
      quantity = cube.split.first.to_i
      color = cube.split.last
      case color
      when "blue"
        minimum_blues = quantity if quantity > minimum_blues
      when "green"
        minimum_greens = quantity if quantity > minimum_greens
      when "red"
        minimum_reds = quantity if quantity > minimum_reds
      end
    end
  end
  minimum_blues * minimum_greens * minimum_reds
end.sum

puts "The solution to part two of the challenge is #{sum}."
### END OF PART 2 SOLUTION ####
