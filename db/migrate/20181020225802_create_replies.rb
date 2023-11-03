class CreateReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.references :quiz,  index: true, foreign_key: true

      t.timestamps
    end
  end
end
