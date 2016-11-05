class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string  :type,        null: false, index: true

      t.integer :owner_id,   null: false
      t.string  :owner_type, null: false
      
      t.integer :resource_id,   null: false
      t.string  :resource_type, null: false

      t.belongs_to :organization, index: true
      
      t.date :started_at
      t.date :ended_at      
    end

    add_index :assignments, [:owner_id, :owner_type, :resource_id, :resource_type], name: "owner_resource_idx"
    add_index :assignments, [:resource_id, :resource_type, :owner_id, :owner_type], name: "resource_owner_idx"
    add_index :assignments, [:started_at, :ended_at]
  end
end
