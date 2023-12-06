first_input = File.readlines("input.txt").map { |i| i.strip.split(": ").last.scan(/\d+/).map(&:to_i) }
second_input = File.readlines("input.txt").map { |i| i.strip.split(": ").last.scan(/\d+/).join.to_i }

first_races = first_input.first.each_with_index.map do |time, i|
  {
    duration: time,
    distance: first_input.last[i]
  }
end

second_races = [{
  duration: second_input.first,
  distance: second_input.last
}]

def calculate_paths_to_victory(races)
  races.map do |race|
    victories = []
    race[:duration].times do |i|
      charge = i
      speed = charge
      record = race[:distance]
      run_time = race[:duration] - charge
      distance = speed * run_time
      is_record = distance > record
      next unless is_record

      victories << race
    end
    victories.count
  end.inject(:*)
end

first_solution = calculate_paths_to_victory(first_races)
puts "The answer to part one is #{first_solution}"

second_solution = calculate_paths_to_victory(second_races)
puts "The answer to part two is #{second_solution}"
