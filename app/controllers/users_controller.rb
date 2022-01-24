class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    if @users
      render json: @users, include: ['todos']
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    if @user
        render json: {
        user: @user
    }
    else
        render json: {
        status: 500,
        errors: ['user not found']
      }
    end
  end

  # POST /users or /users.json
  def create
  @user = User.new(user_params)
    if @user.save
      login!
      render json: {
        status: 200,
        user: @user
      }
    else
      render json: {
        status: 500,  
        errors: @user.errors.full_messages
      }
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :name)
    end
  end
