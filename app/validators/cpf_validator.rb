# frozen_string_literal: true

require 'cpf_cnpj'

class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    return if CPF.valid?(value)

    record.errors.add(attribute, :invalid_cpf)
  end
end
