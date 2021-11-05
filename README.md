# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| relationship_id    | integer | null: false               |

### Association

- has_many :babies

## babies テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| nickname | string     | null: false                    |
| birthday | date       | null: false                    |
| user     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :vaccination_lists

## vaccines テーブル

| Column | Type    | Options     |
| ------ | ------- | ----------- |
| name   | string  | null: false |
| kind   | integer | null: false |

### Association

- has_many :vaccination_lists

## vaccination_lists テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| date       | date       | null: false (only update)      |
| start_date | date       | null: false                    |
| end_date   | date       | null: false                    |
| baby       | references | null: false, foreign_key: true |
| vaccine    | references | null: false, foreign_key: true |

### Association

- belongs_to :baby
- belongs_to :vaccine
