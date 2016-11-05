class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string     :name
      t.belongs_to :office, index: true
      t.belongs_to :organization, index: true

      t.integer :bed_count, default: 0

      t.boolean :active, default: true

      t.timestamps null: false
    end

    add_index :facilities, [:office_id, :active, :organization_id], name: "office_org_act_idx"
  end
end
