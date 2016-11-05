class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :type, limit: 30, index: true

      t.string :first_name,  limit: 30
      t.string :middle_name, limit: 30
      t.string :last_name,   limit: 30
      t.date :dob
      t.string :social
      
      t.belongs_to :organization, index: true

      # Login fields
      t.string :email
      t.string :password
      t.string :salt, limit: 32

      t.boolean :staff,  default: false

      t.boolean :active, default: true

      t.timestamps null: false
    end

    add_index :people, [:email, :password]
    add_index :people, [:type,  :organization_id]
  end
end
