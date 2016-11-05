class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      
      t.belongs_to :organization, index: true

      t.boolean :primary, default: false
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
