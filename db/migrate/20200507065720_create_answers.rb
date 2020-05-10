class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :name, null: false
      t.text :text,   null: false
      t.timestamps
      t.integer :comment_id,   foreign_key: true
    end
  end
end
