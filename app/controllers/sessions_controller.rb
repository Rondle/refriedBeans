class SessionsController < ApplicationController
  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to users_path, :notice => "Hi " + user.fname + " " + user.lname + "!"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end
  def destroy
    reset_session
    redirect_to users_path, :notice => "Good bye!"
  end

end
