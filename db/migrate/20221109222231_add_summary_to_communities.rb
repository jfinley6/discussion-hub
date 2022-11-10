class AddSummaryToCommunities < ActiveRecord::Migration[7.0]
  def change
    add_column :communities, :summary, :text
  end
end
