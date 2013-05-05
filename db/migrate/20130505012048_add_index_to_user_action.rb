class AddIndexToUserAction < ActiveRecord::Migration
  def change
    add_index(:user_actions, [:user_id, :item_id, :user_action_type_id], :name => 'primary_index')
  end
end
