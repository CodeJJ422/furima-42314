FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.email}
    password              {'a00000'}
    password_confirmation {password}
    last_name             {'ふりま'}
    first_name            {'たろう'}
    last_name_kana        {'フリマ'}
    first_name_kana       {'タロウ'}
    birth_date            {'2000-04-03'}
  end
end