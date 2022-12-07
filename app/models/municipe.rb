# frozen_string_literal: true

class Municipe < ApplicationRecord
  has_one_attached :photo

  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  enum status: { active: 0, inactive: 1 }, _default: :active

  validates :name, :cpf, :cns, :email, :birth_date, :phone, :status, :photo, presence: true
  validates :name, length: { minimum: 3 }
  validates :cpf, cpf: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :cns, cns: true
  validates :birth_date, pass_date: true

  scope :ordered, -> { order(:name) }

  after_create :send_welcome_email
  after_save :send_info_changed_email
  after_save :send_sms

  def self.translated_statuses
    statuses.keys.map { |status| [I18n.t("activerecord.attributes.municipe.statuses.#{status}"), status] }
  end

  private

  def send_welcome_email
    MunicipeMailer.with(municipe: self).welcome.deliver_later
  end

  def send_info_changed_email
    MunicipeMailer.with(municipe: self).info_changed.deliver_later
  end

  def send_sms
    TwilioMessenger.new("Olá, #{name}, seu cadastro foi criado/atualizado com sucesso!", phone).call
  end
end
