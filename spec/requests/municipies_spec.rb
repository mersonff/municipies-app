# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Municipies' do
  describe 'GET /municipies' do
    let!(:municipes) { create_list(:municipe, 3) }
    let(:request) { get municipes_path }

    before { request }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all municipies' do
      expect(response.body).to include(*municipes.map(&:name))
    end

    context 'when query is present' do
      let(:request) { get municipes_path, params: { query: municipes.first.name } }

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns filtered municipies', :aggregate_failures do
        expect(response.body).to include(municipes.first.name)
        expect(response.body).not_to include(*municipes.second.name)
      end
    end
  end

  describe 'GET /municipies/:id' do
    let!(:municipe) { create(:municipe) }
    let(:request) { get municipe_path(municipe) }

    before { request }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns municipe' do
      expect(response.body).to include(municipe.name)
    end
  end

  describe 'GET /municipies/new' do
    let(:request) { get new_municipe_path }

    before { request }

    it 'returns http success' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /municipies' do
    let(:address_params) { attributes_for(:address) }
    let(:municipe_params) do
      attributes_for(:municipe).merge(address_attributes: address_params)
    end
    let(:request) { post municipes_path, params: { municipe: municipe_params } }

    context 'when municipe is valid' do
      before do
        request
      end

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'creates municipe' do
        expect(Municipe.count).to eq(1)
      end
    end

    context 'when municipe is invalid' do
      let(:municipe_params) { attributes_for(:municipe, name: nil) }

      before do
        request
      end

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /municipies/:id' do
    let!(:municipe) { create(:municipe) }
    let(:new_params) { attributes_for(:municipe) }
    let(:request) { patch municipe_path(municipe), params: { municipe: new_params } }

    context 'when municipe is valid' do
      before do
        request
      end

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates municipe' do
        expect(municipe.reload.name).to eq(new_params[:name])
      end
    end

    context 'when municipe is invalid' do
      let(:new_params) { attributes_for(:municipe, name: nil) }

      before do
        request
      end

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
