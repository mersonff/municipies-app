# frozen_string_literal: true

class CnsValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    value = value.to_s

    return object.errors.add(attribute, :should_have_exactily_fifteen_characters) if value.length != 15

    object.errors.add(attribute, :cns_invalid) if %w[3 4 5 6].include?(value[0])

    if %w[1 2].include?(value[0])
      object.errors.add(attribute, :cns_invalid) unless cns_valid?(value)
    else
      object.errors.add(attribute, :cns_invalid) unless cns_provisional_valid?(value)
    end
  end

  private

  def cns_valid?(cns)
    number = cns.to_s[0..10]
    cns_pattern = sum_cns(cns, 5..15)
    verifier = calculate_verifier(cns_pattern)

    pattern = if verifier == 10
                verifier = calculate_verifier(2)
                "#{number}001#{verifier}"
              else
                "#{number}000#{verifier}"
              end

    cns.to_s == pattern
  end

  def calculate_verifier(cns_pattern)
    value = 11 - (cns_pattern % 11)
    value = 0 if value == 11
    value
  end

  def cns_provisional_valid?(cns)
    cns_pattern = sum_cns(cns)

    (cns_pattern % 11).zero?
  end

  def sum_cns(cns, target = 1..15)
    target.to_a.reverse.inject(0) { |sum, n| sum + (cns[15 - n].to_i * n) }
  end
end
