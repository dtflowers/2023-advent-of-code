### BEGINNING OF PART 1 SOLUTION ####
input = File.readlines("input.txt")

hands = input.map do |line|
  cards = line.split.first.chars.map do |card|
    if card.to_i > 0
      card.to_i
    else
      case card
      when "T"
        10
      when "J"
        11
      when "Q"
        12
      when "K"
        13
      when "A"
        14
      end
    end
  end

  bid = line.split.last.to_i

  hand = cards.uniq.map do |card|
    count = cards.select { |e| e == card }.count
    {
      card: card,
      count: count,
    }
  end

  hand_type = hand.sort_by { |card_type| card_type[:count] }.reverse.map {|card_type| card_type[:count] }.join
  hand_value =  case hand_type
                when "5"
                  7
                when "41"
                  6
                when "32"
                  5
                when "311"
                  4
                when "221"
                  3
                when "2111"
                  2
                when "11111"
                  1
                end

  {
    bid: bid,
    cards: cards,
    hand_type: hand_type,
    hand_value: hand_value
  }
end

solution = hands.sort_by { |item| [item[:hand_value], item[:cards]] }.each_with_index.map do |hand, i|
  hand[:bid] * (i + 1)
end.sum

puts "The answer to part one is #{solution}"
### BEGINNING OF PART 1 SOLUTION ####
