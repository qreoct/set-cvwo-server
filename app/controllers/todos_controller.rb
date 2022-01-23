class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  # GET /todos or /todos.json
  def index
    @todos = Todo.all
    render json: @todos, include: ['tags', 'users']
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save 
      render json: {
        status: 200,
        todo: @todo
      }
    else 
      render json: {
        status: 400,
        errors: ['Invalid todo']
      }
    end
  end

  def show
    @todo = Todo.find(params[:id])
    render json: @todo
  end

  # PUT /users/1 or /users/1.json
  # update only defined for 'notes' field
  def update
    @todo = Todo.find(params[:id])
      if @todo.update_attribute(:notes, params[:todo][:notes])
        render json: {
          status: 200
        }
      else
        render json: {
          status: 400,
          errors: @todo.errors
        }
      end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    head :no_content, status: :ok
  end

  # GET /todos/1/tags
  def tags
    @todo = Todo.find(params[:id])
    render json: @todo.tags
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @todo = Todo.find(params[:id])
    @tag = Tag.find(@todo.id)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:title, :done)
  end
end