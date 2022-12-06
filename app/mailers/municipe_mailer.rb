class MunicipeMailer < ApplicationMailer
  def welcome
    @municipe = params[:municipe]
    mail(to: @municipe.email, subject: 'Bem vindo ao sistema de vacinação')
  end

  def info_changed
    @municipe = params[:municipe]
    mail(to: @municipe.email, subject: 'Dados alterados com sucesso')
  end
end