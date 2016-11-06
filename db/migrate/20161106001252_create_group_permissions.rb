# 20161106001252
class CreateGroupPermissions < ActiveRecord::Migration
  def change
    create_table :group_permissions do |t|
      t.belongs_to :permission, index: true
      t.belongs_to :group, index: true

      t.string  :level_string
      t.boolean :active, index: true, default: true

      t.timestamps null: false
    end
  end
end