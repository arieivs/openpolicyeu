class ChangeStrategyInPolicyPlan < ActiveRecord::Migration[6.1]
  def change
    rename_column :policy_plans, :strategy, :goals
  end
end
