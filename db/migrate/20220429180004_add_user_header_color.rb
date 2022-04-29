class AddUserHeaderColor < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :header_color, :string, default: '#370617'
    change_column_null :users, :nickname, false, '#370617'
  end
end
