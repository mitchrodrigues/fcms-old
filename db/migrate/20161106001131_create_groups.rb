# 20161106001131
class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.belongs_to :organization, index: true
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
