class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name,       null: false
      t.text :text,         null: false
      t.timestamps
      t.integer :answer_id
    end
  end
end
