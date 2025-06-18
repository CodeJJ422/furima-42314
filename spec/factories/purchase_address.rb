FactoryBot.define do
  factory :purchase_address do
    postal_code    {'111-1101'}
    prefecture_id  {'41'}
    city           {'福岡市'}
    street_address {'西区'}
    building_name  {'マンションA'}
    phone_number   {'12345678901'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end