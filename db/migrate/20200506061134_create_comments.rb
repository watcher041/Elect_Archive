class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name,     null: false
      t.text :text,       null: false
      t.text :answer    
      t.references :user, type: :bigint, foreign_key: true
      t.timestamps
    end
  end
end
