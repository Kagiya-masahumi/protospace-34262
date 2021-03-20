class CreatePrototypes < ActiveRecord::Migration[6.0]
  def change
    create_table :prototypes do |t|
      t.string :title, foreign_key: true
      t.text :catch_copy, foreign_key: true
      t.text :concept, foreign_key: true

      t.timestamps
    end
  end
end
