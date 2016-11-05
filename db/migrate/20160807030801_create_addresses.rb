class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :postal_code
      t.string :state

      t.timestamps null: false
    end
  end
end
