class Address < ApplicationRecord
  belongs_to :municipe

  validates :zipcode, :street, :complement, :neighborhood, :city, :uf, presence: true
end
