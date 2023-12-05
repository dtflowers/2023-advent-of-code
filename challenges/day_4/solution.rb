### BEGINNING OF PART 1 SOLUTION ####
cards = File.readlines("input.txt")

cards.map! do |card|
  name = card.split(": ").first
  winning_numbers = card.split(": ").last.strip.split(" | ").first.split
  numbers = card.split(": ").last.strip.split(" | ").last.split
  {
    name: name,
    winning_numbers: winning_numbers,
    numbers: numbers 
  }
end

values = cards.map do |card|
  winners = card[:numbers].intersection(card[:winning_numbers])
  card_values = winners.count.times.map do |index|
    2**index
  end
  card_values.last
end

solution = values.compact.sum

puts "The solution to part one is #{solution}"
### END OF PART 1 SOLUTION ####

### BEGINNING OF PART 2 SOLUTION ####
cards.map! do |card|
  {
    name: card[:name],
    winning_numbers: card[:numbers].intersection(card[:winning_numbers]).count,
    count: 1
  }
end

total_cards = cards.each_with_index.map do |card, outer_index|
  card[:count].times do |i|
    copies = cards[(outer_index + 1)..outer_index + card[:winning_numbers]]
    copies.each do |copy|
      push_index = copy[:name].split.last.to_i - 1
      cards[push_index][:count] += 1
    end
  end
  card[:count]
end

solution = total_cards.sum

puts "The solution to part two is #{solution}"
### END OF PART 2 SOLUTION ####
