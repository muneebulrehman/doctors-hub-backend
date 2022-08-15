class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.text :bio
      t.string :photo
      t.string :speciality
      t.integer :price

      t.timestamps
    end
  end
end
