class RenameSlotTablesToSlot < ActiveRecord::Migration[7.0]
  def change
    rename_table :slots_tables, :slots
  end
end
