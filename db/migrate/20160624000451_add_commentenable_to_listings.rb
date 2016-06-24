class AddCommentenableToListings < ActiveRecord::Migration
  def change
    add_column :listings, :commentenalbe, :boolean
  end
end
