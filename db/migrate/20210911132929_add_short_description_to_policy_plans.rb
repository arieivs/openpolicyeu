class AddShortDescriptionToPolicyPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :policy_plans, :short_description, :string
  end
end
