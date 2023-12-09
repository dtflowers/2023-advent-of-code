### BEGINNING OF PART 1 & 2 SOLUTION ####
history = File.readlines("input.txt").map do |line|
  line.strip.split.map(&:to_i)
end

history.map! do |sequence|
  sequences = [sequence]
  until sequence.compact.all?(&:zero?)
    sequence = sequence.compact
    sequence = sequence.each_with_index.map do |number, i|
      next if i == sequence.length - 1

      sequence[i + 1] - number
    end
    sequences << sequence.compact
  end
  sequences
end

next_values = history.map do |sequences|
  sequences = sequences.reverse
  new_sequences = sequences.each_with_index.map do |sequence, i|
    if sequence.uniq.count == 1
      sequence << sequence.last
      sequence.unshift(sequence.first)
    else
      sequence << (sequence.last + sequences[i - 1].last)
      sequence.unshift((sequence.first - sequences[i - 1].first))
    end
    sequence
  end
  new_sequences.last
end

first_solution = next_values.map(&:last).sum
second_solution = next_values.map(&:first).sum

puts "The answer to part one is #{first_solution}"
puts "The answer to part two is #{second_solution}"
### END OF PART 1 & 2 SOLUTION ####
