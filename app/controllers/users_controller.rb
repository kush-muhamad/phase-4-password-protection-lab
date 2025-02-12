class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
   rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def create
    user = User.new(user_params)
      session[:user_id] = user.id
      render json: user, status: :created
  end

  def show
    user = User.find_by(id: session[:user_id])
      render json: user
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: { error: "#{exception.model} not found" }, status: :not_found
    end

end