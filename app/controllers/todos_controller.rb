class TodosController < ApplicationController
  # GET /todos or /todos.json
  def index
    @todos = Todo.all
  end

  def create
    @todos = Todo.new
  end

  def update
  end

  def destroy
  end

  # GET /todos/1/tags
  def tags
    @todo.tags
  end
end
