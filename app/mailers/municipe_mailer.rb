# frozen_string_literal: true

class MunicipeMailer < ApplicationMailer
  def welcome
    @municipe = params[:municipe]
    mail(to: @municipe.email, subject: I18n.t('activerecord.messages.municipe.create.success'))
  end

  def info_changed
    @municipe = params[:municipe]
    mail(to: @municipe.email, subject: I18n.t('activerecord.messages.municipe.update.success'))
  end
end
