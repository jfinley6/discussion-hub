class ChangeDefaultUsername < ActiveRecord::Migration[7.0]
  def change
    change_column :accounts, :username, :string, default: "", null: false

  end
end
