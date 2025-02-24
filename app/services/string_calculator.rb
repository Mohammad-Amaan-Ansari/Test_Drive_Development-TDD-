# frozen_string_literal: true

# This Services discribe the String calculation function
class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    delimiter, numbers = extract_delimiter(numbers)

    nums = parse_numbers(numbers, delimiter)
    validate_negatives(nums)

    nums.sum
  end

  def self.extract_delimiter(numbers)
    if numbers.start_with?('//[')
      parts = numbers.split("\n", 2)
      delimiter = parts[0].scan(/\[(.*?)\]/).flatten.map { |d| Regexp.escape(d) }.join('|')
      return [delimiter, parts[1]]
    elsif numbers.start_with?('//')
      parts = numbers.split("\n", 2)
      delimiter = Regexp.escape(parts[0][2])
      return [delimiter, parts[1]]
    end
    [",|\n", numbers]
  end

  def self.parse_numbers(numbers, delimiter)
    numbers.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
  end

  def self.validate_negatives(nums)
    negatives = nums.select(&:negative?)
    raise "negatives not allowed: #{negatives.join(',')}" unless negatives.empty?
  end
end
