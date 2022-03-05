class AddApplyToVolunteerPositions < ActiveRecord::Migration[6.1]
  def change
    add_column :volunteer_positions, :how_to_apply, :string
  end
end
