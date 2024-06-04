class StringCalculator
  def add(string)
    return 0 if string.empty?

    delimiter = /,|\n/
    if string.start_with?("//")
      parts = string.split("\n", 2)
      delimiter = Regexp.escape(parts[0][2])
      string = parts[1]
    end

    numbers = string.split(/#{delimiter}/).map(&:to_i)
    numbers.sum
  end
end
