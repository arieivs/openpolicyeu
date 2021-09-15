class CreateOpportunities < ActiveRecord::Migration[6.1]
  def change
    create_table :opportunities do |t|
      t.string :type
      t.references :organisation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
