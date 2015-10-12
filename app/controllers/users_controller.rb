class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  #before_action :admin_user, only: [:destroy]

  def index

  end

  def show
    @user = User.new.get_user(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @contact = User.new.get_contact(params[:id])
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

  def update_user
    puts params[:user]
    contact = {:first_name => params[:user][:first_name], :last_name => params[:user][:last_name], :email => params[:user][:email],
               :organization_name => params[:user][:organization_name],
               :phone_area_code => params[:user][:phone_area_code],
               :phone_country_code => params[:user][:phone_country_code],
               :phone_number => params[:user][:phone_number],
               :social_security_code1 => params[:user][:social_security_code1],
               :social_security_code2 => params[:user][:social_security_code2],
               :social_security_code3 => params[:user][:social_security_code3],
               :address1 => params[:user][:address1],
               :address2 => params[:user][:address2],
               :postal_code => params[:user][:postal_code],
               :city => params[:user][:city],
               :state_province => params[:user][:state_province],
               :include => params[:user][:include]
             }
    if User.new.update_contact(session[:user_id], contact)
      flash[:success] = "Profile updated"
      redirect_to user_path(session[:user_id])
    # if  @user.update_attributes(user_params)
    #   flash[:success] = "Profile updated"
       #redirect_to root_url
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

    # def user_params
    #
    #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # end

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
