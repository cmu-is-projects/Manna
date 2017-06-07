class SessionsController < ApplicationController
  skip_before_action :check_login, only: [:new, :create]

  def new
    if !current_user.nil?
        redirect_to home_path
    end
  end

  def create
    user = User.find_by_email(params[:email])
    puts "user: #{user.to_yaml}"
    if user && User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: "Logged out!"
  end
end