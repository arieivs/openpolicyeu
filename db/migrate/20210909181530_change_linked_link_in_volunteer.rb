class ChangeLinkedLinkInVolunteer < ActiveRecord::Migration[6.1]
  def change
    rename_column :volunteers, :linked_link, :linkedin_link
  end
end
