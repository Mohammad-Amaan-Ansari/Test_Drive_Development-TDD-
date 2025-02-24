# frozen_string_literal: true

require 'rails_helper'
require_relative '../../app/services/string_calculator'

RSpec.describe StringCalculator do
  describe '#add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add('')).to eq(0)
    end

    it 'returns the number itself when one number is given' do
      expect(StringCalculator.add('1')).to eq(1)
    end

    it 'returns the sum of two numbers' do
      expect(StringCalculator.add('1,2')).to eq(3)
    end

    it 'returns the sum of multiple numbers' do
      expect(StringCalculator.add('1,2,3,4')).to eq(10)
    end

    it 'supports custom delimiters' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it 'raises an error for negative numbers' do
      expect { StringCalculator.add('1,-2,3,-4') }.to raise_error('negatives not allowed: -2,-4')
    end

    it 'ignores numbers greater than 1000' do
      expect(StringCalculator.add('2,1001')).to eq(2)
    end

    it 'supports multi-character delimiters' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it 'supports multiple delimiters' do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
    end
  end
end
