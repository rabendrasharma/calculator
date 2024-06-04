class StringCalculator
  def add(string)
    return 0 if string.empty?

    numbers = string.split(',').map(&:to_i)
    numbers.sum
  end
end
