# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Municipe do
  subject(:municipe) { described_class.new }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cpf) }
  it { is_expected.to validate_presence_of(:cns) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:birth_date) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:photo) }
  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to validate_length_of(:name).is_at_least(3) }

  it { is_expected.to have_one_attached(:photo) }

  it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }

  it 'validates if :cpf is valid' do
    municipe.cpf = '111.561.236-63'
    municipe.validate
    expect(municipe.errors).to have_key(:cpf)
  end

  it 'validates if :cns is valid' do
    municipe.cns = '00000000000'
    municipe.validate
    expect(municipe.errors).to have_key(:cns)
  end

  it 'validates if :email is valid' do
    municipe.email = 'email'
    municipe.validate
    expect(municipe.errors).to have_key(:email)
  end

  it 'validates if :birth_date is valid' do
    municipe.birth_date = Date.current + 1.year
    municipe.validate
    expect(municipe.errors).to have_key(:birth_date)
  end
end
