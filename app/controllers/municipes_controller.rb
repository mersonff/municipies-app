# frozen_string_literal: true

class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[show edit update]

  def index
    @municipes = Municipe.ordered
  end

  def show; end

  def new
    @municipe = Municipe.new
    @municipe.build_address
  end

  def edit; end

  def create
    @municipe = Municipe.new(municipe_params)
    if @municipe.save
      message = I18n.t('activerecord.messages.municipe.create.success')

      respond_to do |format|
        format.html { redirect_to municipes_path, notice: message, status: :ok }
        format.turbo_stream { flash.now[:notice] = message }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    message = I18n.t('activerecord.messages.municipe.update.success')
    if @municipe.update(municipe_params)
      respond_to do |format|
        format.html { redirect_to municipes_path, notice: message, status: :ok }
        format.turbo_stream { flash.now[:notice] = message }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_municipe
    municipe = Municipe.find(params[:id])
    @municipe = helpers.decorate(municipe)
  end

  def municipe_params
    params.require(:municipe).permit(
      :name, :cpf, :cns, :birth_date, :email, :phone, :photo, :status,
      address_attributes: %i[zipcode street complement neighborhood city uf ibge_code]
    )
  end
end
