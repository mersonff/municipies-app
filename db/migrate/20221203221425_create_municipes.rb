class CreateMunicipes < ActiveRecord::Migration[7.0]
  def change
    create_table :municipes do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :cns, null: false
      t.string :email, null: false
      t.date :birth_date, null: false
      t.string :phone, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
