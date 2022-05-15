class AddSlugToHashtags < ActiveRecord::Migration[7.0]
  def change
    add_column :hashtags, :slug, :string
    add_index :hashtags, :slug, unique: true
  end
end
