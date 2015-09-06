class SessionsController < ApplicationController
  def new
  end

  def create
    userobj = User.new
    username = params[:session][:username]
    user_id = userobj.user_id(params[:session][:username])
    password = params[:session][:password]
    puts user_id
    puts password
    user = userobj.authenticate(user_id, params[:session][:password])
    # if user && params[:session][:password]
      if user
        log_in user_id
        username username
    #     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    #     redirect_to_or user
        flash.now[:info] = "Successfully logged in"

    #     message = "Account not activated."
    #     message += "Check your email for the activation link"
    #     flash[:danger] = message
        redirect_to root_url
      #end

     else
      flash.now[:danger] = "Invalid Username/Password Combination"
      render 'new'
     end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
