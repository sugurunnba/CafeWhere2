class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :body
      t.string :review_image_id
      t.integer :user_id
      t.integer :shop_id

      t.timestamps
    end
  end
end
