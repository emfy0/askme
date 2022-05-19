class AddIndexOnCreatedAtHashtags < ActiveRecord::Migration[7.0]
  def change
    add_index :hashtags, :created_at
  end
end
