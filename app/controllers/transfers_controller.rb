class TransfersController < ApplicationController
  before_action :set_and_authenticate_user
  before_action :set_transfer, only: [:show, :update, :destroy]

  # GET /users/:user_id/transfers
  def index
    json_response(@user.transfers)
  end

  # GET /users/:user_id/transfers/:id
  def show
    json_response(@transfer)
  end

  # POST /users/:user_id/transfers
  def create
    @user.transfers.create!(transfer_params)
    json_response(@user, :created)
  end

  # PUT /users/:user_id/transfers/:id
  def update
    @transfer.update(transfer_params)
    head :no_content
  end

  # DELETE /users/:user_id/transfers/:id
  def destroy
    @transfer.destroy
    head :no_content
  end

  private

  def transfer_params
    params.permit(:account_number_from, :account_number_to, :amount_pennies, 
    							:country_code_from, :country_code_to)
  end

  def set_and_authenticate_user
    @user = User.find(params[:user_id])
    unauthorized_entity(@user) if @user != current_user
  end

  def set_transfer
    @transfer = @user.transfers.find_by!(id: params[:id]) if @user
  end
end
