FactoryBot.define do
  factory :item do
    title                   {'テスト'}
    description             {'テスト説明'}
    category_id             {'2'}
    status_id               {'2'}
    shipping_fee_burden_id  {'2'}
    prefecture_id           {'2'}
    shipping_day_id         {'2'}
    price                   {'500'}

    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end
