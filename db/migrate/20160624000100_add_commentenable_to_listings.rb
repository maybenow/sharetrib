class AddCommentenableToListings < ActiveRecord::Migration
  def change
    add_column :listings, :emailenable, :boolean
  end
end
