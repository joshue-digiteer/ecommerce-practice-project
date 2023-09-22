class RemoveUserFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :user, null: false, foreign_key: true
  end
end
