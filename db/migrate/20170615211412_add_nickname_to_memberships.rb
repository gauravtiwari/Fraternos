class AddNicknameToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :nickname, :string
  end
end
