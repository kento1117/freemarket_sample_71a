class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.references :item_id,null: false, FK: true
      t.string :image_url,null: false
      t.timestamps
    end
  end
end

