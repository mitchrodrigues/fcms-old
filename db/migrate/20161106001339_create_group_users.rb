# 20161106001339
class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :person_id
      t.integer :person_type
      
      t.belongs_to :group,  index: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
