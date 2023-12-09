### BEGINNING OF PART 1 SOLUTION ####
history = File.readlines("input.txt").map do |line|
  line.strip.split.map(&:to_i)
end

history.map! do |sequence|
  sequences = [sequence]
  until sequence.compact.all?(&:zero?)
    i = 0
    sequence = sequence.compact
    sequence.map! do |number|
      next if i == sequence.length - 1

      i += 1
      interval = sequence[i] - number
      interval
    end
    sequences << sequence.compact
  end
  sequences
end

next_values = history.map do |sequences|
  i = 0
  sequences = sequences.reverse
  sequences.map! do |sequence|
    if sequence.uniq.count == 1
      sequence << sequence.last
    else
      sequence << (sequence.last + sequences[i - 1].last)
    end
    i += 1
    sequence
  end
  sequences.last.last
end

solution = next_values.sum

puts "The answer to part one is #{solution}"
### END OF PART 1 SOLUTION ####
