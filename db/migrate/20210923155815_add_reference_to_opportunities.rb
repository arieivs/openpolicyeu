class AddReferenceToOpportunities < ActiveRecord::Migration[6.1]
  def change
    add_reference :opportunities, :opportunity_type, null: false, foreign_key: true
  end
end
