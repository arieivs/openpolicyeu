class ChangeHowContributedInYoungContributor < ActiveRecord::Migration[6.1]
  def change
    rename_column :young_contributors, :how_contributed, :description
    rename_column :young_contributors, :linkedin_link, :website_url
  end
end
