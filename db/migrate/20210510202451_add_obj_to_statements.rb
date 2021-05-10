class AddObjToStatements < ActiveRecord::Migration[6.0]
  def change
    add_reference :statements, :obj, null: true, foreign_key: true
    add_column :statements, :resource_object_id, :integer, null: true
  end
end
