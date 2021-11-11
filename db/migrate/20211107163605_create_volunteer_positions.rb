class CreateVolunteerPositions < ActiveRecord::Migration[6.1]
  def change
    create_table :volunteer_positions do |t|
      t.string :name
      t.string :description
      t.string :requirements
      t.string :team

      t.timestamps
    end
  end
end
