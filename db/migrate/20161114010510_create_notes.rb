class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :creator, polymorphic: true, index: true
      t.string :type
      t.text :note
      t.string :privacy, default: 'public'
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
