calibration_document = File.readlines("input.txt")

calibration_values = calibration_document.map do |line|
  numerals = line.chars.select! { |char| char.match(/[0-9]/) }
  (numerals.first + numerals.last).to_i
end

puts "The solution to the first question is #{calibration_values.sum}"