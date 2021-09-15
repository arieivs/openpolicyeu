class CreateOrganisations < ActiveRecord::Migration[6.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :description
      t.string :learn_more_link

      t.timestamps
    end
  end
end
