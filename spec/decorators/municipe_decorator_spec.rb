# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MunicipeDecorator do
  subject(:decorated) { BaseDecorator.new(described_class).decorate(municipe) }

  describe '#br_birth_date' do
    context 'when birth_date is nil' do
      let(:municipe) { build(:municipe, birth_date: nil) }

      it 'returns nil' do
        expect(decorated.br_birth_date).to be_nil
      end
    end

    context 'when birth_date is present' do
      let(:birth_date) { '2020-01-01' }
      let(:municipe) { build(:municipe, birth_date: birth_date) }

      it 'returns birth_date in br format' do
        expect(decorated.br_birth_date).to eq('01/01/2020')
      end
    end
  end
end
