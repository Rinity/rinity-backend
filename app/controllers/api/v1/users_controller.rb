class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    render json: user, serializer: Api::V1::UserSerializer
  end

  def index
    users = User.limit(10)
    render json: users# , serializer: Api::V1::UserSerializer
  end
end
