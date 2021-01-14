class SessionsController < ApplicationController 
  def new 
    @user = User.new
  end

  def create 
    # TODO: check if user credential match
    # redirect to the user's show page if successful
    # else render the /login form with message "PennKey or Password Incorrect"
    @user = User.find_by(pennkey: params[:pennkey]) 
    if @user && @user.password == params[:password]       
      session[:user_id] = @user.id       
      redirect_to @user 
    else 
      @message = 'User name not found'
      render :new 
    end
  end
  
  def destroy 
    # TODO: reset session and redirect to /login
    reset_session
    redirect_to '/login'
  end 
end