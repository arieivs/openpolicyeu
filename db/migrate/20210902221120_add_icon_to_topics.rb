class AddIconToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :icon, :string
    add_column :topics, :icon_color, :string
  end
end
