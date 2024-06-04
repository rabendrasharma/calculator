# lib/string_calculator.rb
class StringCalculator
  def add(string)
    return 0 if string.empty?

    delimiter = /,|\n/
    if string.start_with?("//")
      parts = string.split("\n", 2)
      if parts[0] =~ /\/\/(\[.+?\])+/
        delimiter = parts[0].scan(/\[(.+?)\]/).map { |d| Regexp.escape(d[0]) }.join('|')
      else
        delimiter = Regexp.escape(parts[0][2])
      end
      string = parts[1]
    end

    numbers = string.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
    negatives = numbers.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" unless negatives.empty?

    numbers.sum
  end
end
