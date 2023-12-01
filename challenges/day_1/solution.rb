### BEGINNING OF PART 1 SOLUTION ####
calibration_document = File.readlines("input.txt")

calibration_values = calibration_document.map do |line|
  numerals = line.chars.select! { |char| char.match(/[0-9]/) }
  (numerals.first + numerals.last).to_i
end

puts "The solution to the first question is #{calibration_values.sum}"
### END OF PART 1 SOLUTION ####

### BEGINNING OF PART 2 SOLUTION ####
digits = [
  { one: 1 },
  { two: 2 },
  { three: 3 },
  { four: 4 },
  { five: 5 },
  { six: 6 },
  { seven: 7 },
  { eight: 8 },
  { nine: 9 }
]

new_values = []

calibration_document.map do |line|
  line_values = []

  digits.each do |digit|
    next unless line.index(digit.keys.first.to_s)

    indices = line.enum_for(:scan, /(?=#{digit.keys.first})/).map do
      Regexp.last_match.offset(0).first
    end

    indices.each do |index|
      line_values.delete_at(index)
      line_values.insert(index, digit.values.first)
    end
  end

  line.chars.each_with_index do |char, index|
    if char.match(/[0-9]/)
      line_values.delete_at(index)
      line_values.insert(index, char.to_i)
    end
  end

  new_values << line_values.compact
end

new_calibration_values = new_values.map do |line_values|
  "#{line_values.first}#{line_values.last}".to_i
end

puts "The solution to the second question is #{new_calibration_values.sum}"
### END OF PART 2 SOLUTION ####
