class RemoveTitleFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :title, :text
  end
end
