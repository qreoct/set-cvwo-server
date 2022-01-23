class AddNotesToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :notes, :string
  end
end
