class DeviseInvitableAddToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_created_at, :datetime
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_limit, :integer
    add_column :users, :invitations_count, :integer, default: 0

    add_reference :users, :invited_by, polymorphic: true, index: true

    add_index :users, :invitation_token, unique: true
    add_index :users, :invitations_count
  end
end
