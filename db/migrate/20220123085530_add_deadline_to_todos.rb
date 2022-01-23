class AddDeadlineToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :deadline, :string
  end
end
