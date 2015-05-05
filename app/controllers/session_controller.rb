# session_controller.rb
class SessionController < ApplicationController
  # GET
  def new
  end

  # POST
  def create
    @user = User.find_by_email(params[:login][:email])
    respond_to do |format|
      if @user.present? && set_current_user
        format.html { redirect_to dashboard_index_path, notice: 'Successful login.' }
      else
        format.html { render :new, notice: 'Something wrong...' }
      end
    end
  end

  def destroy
  end

  private

  def set_current_user
    session[:user_id] = @user.id
    session[:user_type] = @user.type
    session[:user_name] = "#{@user.name}(#{@user.email})"
    true
  end
end
