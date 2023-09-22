class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_no, :string
    add_column :users, :address, :string
    add_column :users, :role, :integer, :default => 1
  end
end
