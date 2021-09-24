class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :opportunities, :type, :opportunity_type
  end
end
