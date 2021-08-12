class CreateVolunteers < ActiveRecord::Migration[6.1]
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :role
      t.string :linked_link

      t.timestamps
    end
  end
end
