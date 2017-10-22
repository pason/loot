class UsersController < ApplicationController
	before_action :set_user, only: [:show, :update, :destroy]

  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  def show
    json_response(@user)
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :address_line_1, :date_of_birth,
                  :password, :password_confirmation, :username)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
