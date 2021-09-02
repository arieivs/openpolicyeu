class RemoveDescriptionFromInstitutions < ActiveRecord::Migration[6.1]
  def change
    remove_column :institutions, :description, :string
  end
end
