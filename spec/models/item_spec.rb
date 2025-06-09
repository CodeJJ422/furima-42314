require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it '全ての情報が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'titleが空では保存できない' do
        @item.title = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it 'titleが41文字以上では保存できない' do
        @item.title = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Title は40文字以内で入力してください")
      end

      it 'descriptionが空では保存できない' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'descriptionが1001文字以上では保存できない' do
        @item.description = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Description は1000文字以内で入力してください")
      end

      it 'category_idが1では保存できない' do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'status_idが1では保存できない' do
        @item.status_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'shipping_fee_burden_idが1では保存できない' do
        @item.shipping_fee_burden_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee burden can't be blank")
      end

      it 'prefecture_idが1では保存できない' do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'shipping_day_idが1では保存できない' do
        @item.shipping_day_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it 'priceが空では保存できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字では保存できない' do
        @item.price = "３００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'priceが300未満では保存できない' do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceが10,000,000以上では保存できない' do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end
