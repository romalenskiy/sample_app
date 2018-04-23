class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      # remember(@user) if params[:session][:remember_me] == '1'
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = "Logged in successfully!"
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
