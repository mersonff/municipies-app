class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :municipe, null: false, foreign_key: true
      t.string :zipcode, null: false
      t.string :street, null: false
      t.string :complement, null: false
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :uf, null: false
      t.string :ibge_code

      t.timestamps
    end
  end
end
