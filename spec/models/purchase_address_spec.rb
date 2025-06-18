require 'rails_helper'

#bundle exec rspec spec/models/purchase_address_spec.rb

RSpec.describe PurchaseAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
    sleep(1)
  end
  describe '商品購入' do

    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@purchase_address).to be_valid
      end
      it 'building_nameは空でも購入できる' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
    end

    context '購入できないとき' do
      it 'postal_codeが空だと購入できない' do
        @purchase_address.postal_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeがハイフンを含んでいないと購入できない' do
        @purchase_address.postal_code = "1110000"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'postal_codeが3桁ハイフン4桁の半角文字列でないと購入できない' do
        @purchase_address.postal_code = "111-000"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが1では購入できない' do
        @purchase_address.prefecture_id = "1"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと購入できない' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'street_addressが空だと購入できない' do
        @purchase_address.street_address = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Street address can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @purchase_address.phone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下だと購入できない' do
        @purchase_address.phone_number = "123456789"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は10〜11桁の半角数字で入力してください（例: 09012345678）")
      end

      it 'phone_numberが12桁以上だと購入できない' do
        @purchase_address.phone_number = "123456789012"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は10〜11桁の半角数字で入力してください（例: 09012345678）")
      end

      it 'phone_numberが半角数字でないと購入できない' do
        @purchase_address.phone_number = "１２３４５６７８９０１"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number は10〜11桁の半角数字で入力してください（例: 09012345678）")
      end

      it 'userが紐づいていないと購入できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていないと購入できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空だと購入できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end