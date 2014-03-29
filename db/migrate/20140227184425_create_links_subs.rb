class CreateLinksSubs < ActiveRecord::Migration
  def change
    create_table :links_subs do |t|
      t.references :link
      t.references :sub

      t.timestamps
    end
  end
end
