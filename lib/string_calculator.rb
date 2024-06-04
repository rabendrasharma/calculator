# lib/string_calculator.rb
class StringCalculator
  def add(string)
    return 0 if string.empty?

    delimiter, numbers_string = extract_delimiter_and_numbers(string)
    numbers = extract_numbers(numbers_string, delimiter)

    validate_numbers(numbers)

    numbers.reject { |n| n > 1000 }.sum
  end

  private

  def extract_delimiter_and_numbers(string)
    if string.start_with?("//")
      parts = string.split("\n", 2)
      delimiter = extract_custom_delimiters(parts[0])
      [delimiter, parts[1]]
    else
      [/[,|\n]/, string]
    end
  end

  def extract_custom_delimiters(header)
    if header =~ /\/\/(\[.+?\])+/
      header.scan(/\[(.+?)\]/).map { |d| Regexp.escape(d[0]) }.join('|')
    else
      Regexp.escape(header[2])
    end
  end

  def extract_numbers(numbers_string, delimiter)
    numbers_string.split(/#{delimiter}/).map(&:to_i)
  end

  def validate_numbers(numbers)
    negatives = numbers.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?
  end
end
