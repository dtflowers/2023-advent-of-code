### BEGINNING OF PART 1 SOLUTION ####
lines = File.readlines("test.txt")

numbers_coordinates = []
symbol_coordinates = []

lines.each_with_index do |line, outer_index|
  items = line.strip.split(".")
  items.reject!(&:empty?) if items.count > 1
  items.each do |item|
    length = item.length
    is_number = item.scan(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/).empty?
    if is_number
      number = item
      numbers_coordinates << {
        key: number,
        value: number.to_i,
        starting_coordinates: "(#{line.index(number)}, #{outer_index})"
      }
    elsif length == 1
      symbol = item
      symbol_coordinates << "(#{line.index(symbol)}, #{outer_index})"
    else
      numbers = item.scan(/\d+/)
      symbols = item.scan(/[!@#$%^&*()_+{}\[\]:;'"\/\\?><.,]/)
      numbers.each_with_index do |number, inner_index|
        numbers_coordinates << {
          key: number,
          value: number.to_i,
          starting_coordinates: "(#{line.index(number)}, #{outer_index})"
        }
      end
      symbols.each_with_index do |symbol, inner_index|
        symbol_coordinates << "(#{line.index(symbol) + inner_index}, #{outer_index})"
      end
    end
  end
end

pp numbers_coordinates

pp symbol_coordinates

