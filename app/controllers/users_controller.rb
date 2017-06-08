class UsersController < ApplicationController
  # before_filter :login_required, except: [:new, :create]
  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @active_users = User.active.alphabetical.paginate(page: params[:page]).per_page(10)
    if (current_user.role?(:admin) || current_user.role?(:head_deacon))
      @inactive_users = User.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        # session[:user_id] = @user.id
        redirect_to home_path, notice: "#{@user.proper_name} has been created!"
      else
        render action: 'new'
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to home_path, notice: "#{@user.proper_name}'s profile has been updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "#{@user.name} was removed from the system."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :role, :active, :password, :password_confirmation)
    end
end
