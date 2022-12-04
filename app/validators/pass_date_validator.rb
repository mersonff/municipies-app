# frozen_string_literal: true

class PassDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present? && value > Date.current

    message = options[:message] || :pass_date
    record.errors.add(attribute, message)
  end
end
