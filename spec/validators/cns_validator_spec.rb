# frozen_string_literal: true

require 'rails_helper'

class CNSValidatable
  include ActiveModel::Validations
  attr_accessor :cns

  validates :cns, cns: true
end

describe CnsValidator do
  subject(:validatable) { CNSValidatable.new }

  let :short_cns do
    '1122334411'
  end

  let :invalid_cns do
    '209156687130003'
  end

  let :other_invalid_cns do
    '123456789101112'
  end

  let :valid_cns do
    '209179687130003'
  end

  let :invalid_provisional_cns do
    '898002143308856'
  end

  let :valid_provisional_cns do
    '898001033308856'
  end

  describe '#validate_each' do
    context 'when validating CNS length' do
      it 'is invalid' do
        validatable.cns = short_cns

        validatable.valid?

        expect(validatable.errors['cns']).to eq ['Deve ter exatamente 15 caractéres']
      end

      it 'is valid' do
        validatable.cns = valid_cns

        expect(validatable).to be_valid
      end
    end

    context 'with CNS' do
      it 'is valid' do
        validatable.cns = valid_cns

        expect(validatable).to be_valid
      end

      it 'is invalid' do
        validatable.cns = invalid_cns

        validatable.valid?

        expect(validatable.errors['cns']).to eq ['Número de cartão inválido']
      end

      it 'is other invalid' do
        validatable.cns = other_invalid_cns

        validatable.valid?

        expect(validatable.errors['cns']).to eq ['Número de cartão inválido']
      end
    end

    context 'with provisional CNS' do
      it 'is valid' do
        validatable.cns = valid_provisional_cns

        expect(validatable).to be_valid
      end

      it 'is invalid' do
        validatable.cns = invalid_provisional_cns

        validatable.valid?

        expect(validatable.errors['cns']).to eq ['Número de cartão inválido']
      end
    end
  end
end
