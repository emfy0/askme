class CreateHashtags < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtags do |t|
      t.string :text, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
