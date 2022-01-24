class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  # GET /todos or /todos.json
  def index
    @todos = Todo.all
    render json: @todos, include: ['tags', 'users']
  end

  # POST /todos
  # TODO: this is the UGLIEST controller function ever...
  # i absolutely must learn how to finesse multiple associations... eventually
  def create
    hash = {}
    hash[:id] = params[:props][:todo][:id]
    hash[:title] = params[:props][:todo][:title]
    hash[:done] = params[:props][:todo][:done]
    hash[:deadline] = params[:props][:todo][:deadline]
    hash[:notes] = params[:props][:todo][:notes]
    @todo = Todo.new(hash)
    @todo.save!
    params[:props][:todo][:tags].map do |t|
      user = User.find(params[:props][:currentUser][:id])
      tag = Tag.find_or_create_by!(name: t[:name], user: user)
      @todo.taggings.create(tag: tag)
    end

    params[:props][:todo][:users].map do |u|
      user = User.find_by(id: u[:id])
      user.assignments.create(todo: @todo)
    end

    if @todo 
      render json: {
        status: 200,
        todo: @todo,
      }, :include => ['tags', 'users']
    else 
      render json: {
        status: 400,
        errors: ['Unable to create todo']
      }
    end
  end

  def show
    @todo = Todo.find(params[:id])
    render json: @todo
  end

  # PUT /todos/1 or /todos/1.json
  # update only defined for 'notes' and 'completed'
  def update
    @todo = Todo.find(params[:id])
      if @todo.update(:notes => params[:todo][:notes], :done => params[:todo][:done])
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
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:id, :title, :done,
      :deadline, :notes, :users => [:id, :name, :username, :created_at, :updated_at, :todos], :tags => [:name])
  end
end