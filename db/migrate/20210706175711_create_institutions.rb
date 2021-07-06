class CreateInstitutions < ActiveRecord::Migration[6.1]
  def change
    create_table :institutions do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :website_url
      t.string :video_url
      t.string :video_alt_text
      t.string :video_source
      t.references :ambassador, null: true, foreign_key: true

      t.timestamps
    end
  end
end
