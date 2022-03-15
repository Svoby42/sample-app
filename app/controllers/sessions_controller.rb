class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password]) #same as user && user.authenticate
      log_in user
      redirect_to user #same as redirect_to user_url(user)
    else
      flash.now[:danger] = "Nesprávný email/heslo"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
