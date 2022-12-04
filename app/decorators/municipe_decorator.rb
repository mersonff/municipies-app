class MunicipeDecorator < BaseDecorator
  def br_birth_date
    return nil unless birth_date

    birth_date.strftime('%d/%m/%Y')
  end
end