class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  #before_action :admin_user, only: [:destroy]

  def index
    #@users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    #@microposts = @user.microposts.paginate(page: params[:page])
      @user = User.new.get_user(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    #@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      #log_in @user
      flash[:info] = "Please check your email for account activation"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    if  @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    def set_user
      @user = User.new.get_user(current_user[:user_id])
    end

    def user_params

      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    # returns correct user to edit and update user
    def correct_user
      @user = User.new.get_user(current_user[:user_id])
      redirect_to root_url unless current_user?(@user)
    end

    # only admin users
    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
