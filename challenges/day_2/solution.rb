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
    array = result.strip.split(", ")
    array.each do |cubes|
      quantity_and_color = cubes.split
      quantity = quantity_and_color.first.to_i
      color = quantity_and_color.last
      case color
      when "blue"
        if quantity > most_blues
          most_blues = quantity
        end
      when "green"
        if quantity > most_greens
          most_greens = quantity
        end
      when "red"
        if quantity > most_reds
          most_reds = quantity
        end
      end
    end
  end
  blue_impossible = most_blues > maximum_blues
  green_impossible = most_greens > maximum_greens
  red_impossible = most_reds > maximum_reds
  impossible = (blue_impossible || green_impossible|| red_impossible)
  if impossible
    0
  else
    game.split(": ").first.split.last.to_i
  end
end.sum

puts "The solution to part one of the challenge is #{sum}."
