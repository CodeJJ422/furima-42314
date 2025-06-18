class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_purchaser
  before_action :redirect_if_purchased, only: :index

  def index
    @purchase_address = PurchaseAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_purchaser
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def redirect_if_purchased
    if @item.purchase.present?
      redirect_to root_path
    end
  end

end
