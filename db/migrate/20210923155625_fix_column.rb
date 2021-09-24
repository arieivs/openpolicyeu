class FixColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :opportunities, :opportunity_type
  end
end
