class CreateTweets < ActiveRecord::Migration[8.1]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false
      t.references :parent, foreign_key: { to_table: :tweets }, index: true
      t.integer :replies_count, default: 0, null: false
      t.integer :likes_count, default: 0, null: false

      t.timestamps
    end
  end
end
