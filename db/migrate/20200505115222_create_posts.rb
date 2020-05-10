class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title,    null: false, default: ""
      t.string :author,   null: false, default: ""
      t.text :image,      null: false
      t.text :text,       null: false
      t.timestamps
      t.integer :user_id,  foreign_key: true
    end
  end
end
