# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MunicipeMailer do
  describe '#welcome' do
    let(:municipe) { create(:municipe) }
    let(:mail) { described_class.with(municipe: municipe).welcome }

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq(I18n.t('activerecord.messages.municipe.create.success'))
      expect(mail.to).to eq([municipe.email])
      expect(mail.from).to eq(['from@example.com'])
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe '#info_changed' do
    let(:municipe) { create(:municipe) }
    let(:mail) { described_class.with(municipe: municipe).info_changed }

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq(I18n.t('activerecord.messages.municipe.update.success'))
      expect(mail.to).to eq([municipe.email])
      expect(mail.from).to eq(['from@example.com'])
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
