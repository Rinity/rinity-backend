# session_controller.rb
class SessionController < ApplicationController

  # GET
  def new
  end

  # POST
  def create
    @user = User.find_by_email(params[:login][:email])
    respond_to do |format|
      if @user
        session[:user_id] = @user.id
        session[:user_type] = @user.type
        session[:user_name] = "#{@user.name}(#{@user.email})"
        format.html { redirect_to dashboard_index_path, notice: 'Successful login.' }
        format.json { render :show, status: :created, location: rides_path }
      else
        format.html { render :new, notice: 'Something wrong...'}
        format.json { render json: { error: 'Something wrong...' }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end
end
