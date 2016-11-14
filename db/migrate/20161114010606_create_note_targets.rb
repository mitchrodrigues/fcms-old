class CreateNoteTargets < ActiveRecord::Migration
  def change
    create_table :note_targets do |t|
      t.references :noteable, polymorphic: true, index: true
      t.belongs_to :note, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
