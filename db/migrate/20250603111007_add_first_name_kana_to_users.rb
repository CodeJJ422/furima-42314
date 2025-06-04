class AddFirstNameKanaToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name_kana, :string
  end
end
