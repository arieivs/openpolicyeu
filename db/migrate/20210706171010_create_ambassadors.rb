class CreateAmbassadors < ActiveRecord::Migration[6.1]
  def change
    create_table :ambassadors do |t|
      t.string :name
      t.string :description
      t.string :social_profile_link

      t.timestamps
    end
  end
end
