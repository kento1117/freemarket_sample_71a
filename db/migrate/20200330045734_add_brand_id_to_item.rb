class AddBrandIdToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :brand, null:false,foreign_key: true
  end
end
