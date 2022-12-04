# frozen_string_literal: true

require 'rails_helper'

class PassDateValidatable
  include ActiveModel::Validations
  attr_accessor :birth_date

  validates :birth_date, pass_date: true
end

describe PassDateValidator do
  subject(:validatable) { PassDateValidatable.new }

  context 'when date is greater than current date' do
    before { validatable.birth_date = 1.day.from_now }

    it 'is invalid' do
      expect(validatable).not_to be_valid
    end

    it 'adds an error on model' do
      validatable.valid?
      expect(validatable.errors.attribute_names).to include(:birth_date)
    end
  end
end
