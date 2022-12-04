# frozen_string_literal: true

require 'rails_helper'

class CPFValidatable
  include ActiveModel::Validations
  attr_accessor :cpf

  validates :cpf, cpf: true
end

describe CpfValidator do
  subject(:validatable) { CPFValidatable.new }

  context 'when it is an invalid CPF' do
    before { validatable.cpf = '431.321.551-12' }

    it 'is invalid' do
      expect(validatable).not_to be_valid
    end

    it 'adds an error on model' do
      validatable.valid?
      expect(validatable.errors.attribute_names).to include(:cpf)
    end
  end

  context "when it's does not have CPF format" do
    before { validatable.cpf = '431.321' }

    it 'is invalid' do
      expect(validatable).not_to be_valid
    end

    it 'adds an error on model' do
      validatable.valid?
      expect(validatable.errors.attribute_names).to include(:cpf)
    end
  end

  it 'is valid when it is a CPF' do
    validatable.cpf = '865.922.358-61'
    expect(validatable).to be_valid
  end
end
