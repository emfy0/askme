class AddFromUserIdToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :from_user_id, :integer
  end
end
