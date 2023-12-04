### BEGINNING OF PART 1 SOLUTION ####
cards = File.readlines("input.txt")

cards.map! do |card|
  name = card.split(": ").first
  winning_numbers = card.split(": ").last.strip.split(" | ").first.split(" ")
  numbers = card.split(": ").last.strip.split(" | ").last.split(" ")
  {
    name: name,
    winning_numbers: winning_numbers,
    numbers: numbers 
  }
end

values = cards.each.map do |card|
  winners = card[:numbers].intersection(card[:winning_numbers])
  card_values = winners.count.times.map do |index|
    2**index
  end
  card_values.last
end

solution = values.compact.sum

puts "The solution to part one is #{solution}."
### END OF PART 1 SOLUTION ####
