class AddWeixinToPerson < ActiveRecord::Migration
  def change
    add_column :people, :weixin, :string
  end
end
