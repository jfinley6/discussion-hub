class ChangeDefaultKarma < ActiveRecord::Migration[7.0]
  def change
    change_column :accounts, :karma, :integer, default: 0
  end
end
