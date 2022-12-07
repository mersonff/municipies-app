# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  it { is_expected.to belong_to(:municipe) }
  it { is_expected.to validate_presence_of(:zipcode) }
  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:complement) }
  it { is_expected.to validate_presence_of(:neighborhood) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:uf) }
end
