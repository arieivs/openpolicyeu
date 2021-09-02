class AddDescriptionToPolicyMakingInstitutions < ActiveRecord::Migration[6.1]
  def change
    add_column :policy_making_institutions, :description, :string
  end
end
