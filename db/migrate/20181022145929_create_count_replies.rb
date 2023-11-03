class CreateCountReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :count_replies do |t|
      t.string :title
      t.references :quiz, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
