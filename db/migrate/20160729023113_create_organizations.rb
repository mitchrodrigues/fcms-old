class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name,     length: 30
      t.boolean :active, default: true
      t.timestamps null: false
    end
  end
end
