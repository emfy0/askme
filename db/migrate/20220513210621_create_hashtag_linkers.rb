class CreateHashtagLinkers < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtag_linkers do |t|
      t.belongs_to :question
      t.belongs_to :hashtag

      t.timestamps
    end
  end
end
