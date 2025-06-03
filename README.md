# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| password           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association
has_many :items
has_many :purchases

## items テーブル

| Column              | Type        | Options     |
| ------------------- | ----------- | ----------- |
| title               | string      | null: false |
| description         | text        | null: false |
| category            | string      | null: false |
| status              | string      | null: false |
| shipping_fee_burden | string      | null: false |
| shipping_from_area  | string      | null: false |
| shipping_days       | integer     | null: false |
| price               | integer     | null: false |
| user                | references  | null: false, foreign_key: true |

### Association
has_one :purchase
belong_to :user

## purchases テーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| item       | references | null: false, foreign_key: true |
| user       | references | null: false, foreign_key: true |

### Association
belongs_to :item
belongs_to :user
has_one :address

## address テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| postal_code     | string     | null: false |
| prefecture      | string     | null: false |
| city            | string     | null: false |
| street_address  | string     | null: false |
| building_name   | string     |             |
| phone_number    | string     | null: false |

### Association
belongs_to :purchase

