# アプリ名

&emsp;「BabyApp」

<br>

# 概要

&emsp;赤ちゃんのワクチン接種状況を管理するアプリケーションです。

<br>

# URL

http://18.181.103.178

<br>

# 使用技術（開発環境）

- Ruby 2.6.5
- Ruby on Rails 6.1.4.1
- JavaScript
- MySQL 5.6.51
- Nginx
- AWS
  - EC2
- Capistrano
- RSpec
- FullCalendar
- Bootstrap

<br>

# DEMO

### トップページ（接種状況・カレンダー）

[![Image from Gyazo](https://i.gyazo.com/9ca329ccb3fcae73a5aaa25451b37a60.gif)](https://gyazo.com/9ca329ccb3fcae73a5aaa25451b37a60)
<br>

### ワクチン接種日登録画面

[![Image from Gyazo](https://i.gyazo.com/857336a302c5e9953abc88a5792bcfb5.gif)](https://gyazo.com/857336a302c5e9953abc88a5792bcfb5)

### ワクチン接種日詳細画面

[![Image from Gyazo](https://i.gyazo.com/a7abad3523251b1749491e760ab476c2.gif)](https://gyazo.com/a7abad3523251b1749491e760ab476c2)

### 赤ちゃん登録画面・一覧画面

[![Image from Gyazo](https://i.gyazo.com/eb8e00a1661f2b407673c2afdbf739e7.gif)](https://gyazo.com/eb8e00a1661f2b407673c2afdbf739e7)

<br>

# 制作背景（意図）

&emsp;幼少期に接種を受けるべきワクチンは種類が多く、それぞれに接種期限や接種可能期間があり、複雑に絡み合っていて管理をするのが大変です。
<br>
&emsp;ただでさえ赤ちゃんを育てる親は精神的にも肉体的にも負担が大きいので、少しでも負担を減らすために役立つアプリを作りたいと思い、制作を始めました。

<br>

# 工夫したポイント

&emsp;ワクチンの接種状況が一目でわかるようにしています。
<br>
&emsp;接種日を経過すると自動で接種済と表示されます。
<br>
&emsp;また、カレンダーも接種状況に応じて表示が変更されます。

- 未接種 → 接種可能期間
- 予定日入力 → 予定日の表示
- 予定日を経過 → 接種済の表示

&emsp;接種状況のボタンをクリックするか、カレンダーに表示されている予定をクリックすることで、接種日の登録や詳細を確認することができます。
<br>
&emsp;短期間で接種を受けるために、接種可能期間が重なっているワクチンは同時に接種を受けることが推奨されているため、接種日を登録する際にチェックボックスでワクチン名を選択することで、複数のワクチンの接種日を同時に登録することができます。
<br>
&emsp;２人目、３人目と複数の子供を登録し、同時に接種状況を管理することができます。

<br>

# 課題や今後実装したい機能

&emsp;ワクチン接種は医療に関する重要なことなので、個人で開発するのではなくチームでチェックする必要があると感じました。
<br>
&emsp;また、このアプリを世に広めて安全に使用していただくためには専門家の監修が必要になります。
<br>
&emsp;今後は Google カレンダーなどのカレンダーアプリとの連携や、ワクチン接種以外の予定の追加機能、医療機関へワクチン接種の予約をするために近隣の病院を検索する機能などの実装を追加していく予定です。
<br>
&emsp;また、スマートフォンでも利用しやすいように、レスポンシブ対応にさらに力を入れようと思います。

<br>

# ER 図

![baby_app_erd_ja](https://user-images.githubusercontent.com/87280711/144734717-0e6021e5-cd1f-475b-84da-b1d80114a4d9.png)

<br>

# 画面遷移図

![baby_app_sfd](https://user-images.githubusercontent.com/87280711/144734735-199df7ea-a56c-47ef-9814-5ea57ffb637c.png)

<br>

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
