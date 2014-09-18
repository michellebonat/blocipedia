class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :wiki, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
