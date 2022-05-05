class AddAuthorToQuestions < ActiveRecord::Migration[7.0]
  change_table :questions do |t|
    t.belongs_to :author, foreign_key: { to_table: :users }
  end
end
