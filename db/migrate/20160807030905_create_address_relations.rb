class CreateAddressRelations < ActiveRecord::Migration
  def change
    create_table :address_relations do |t|
      t.integer :owner_id
      t.string :owner_type
      t.belongs_to :address, index: true

      t.boolean :primary

      t.date :started_at
      t.date :ended_at
    end

    add_index :address_relations, [:owner_id, :owner_type]
  end
end
