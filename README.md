## users テーブル

| Column      | Type    | Options     |
| --------    | ------  | ---------   |
| email       | string  | null: false |
| password    | string  | null: false |
| name        | string  | null: false |
| profile     | text    | null: false |
| occupation  | text    | null: false |
| position    | text    | null: false |

### Association

- has_many :comments
- has_many :prototypes


## prototype テーブル

| Column      | Type        | Options         |
| --------    | ------      | ---------       |
| title       | string      | null: false     |
| catch_copy  | text        | null: false     |
| concept     | text        | null: false     |
| user        | references  |                 |

### Association
- has_many :comments
- belongs_to :user


## prototype_users テーブル

| Column      | Type        | Options                             |
| --------    | ------      | ---------                           |
| user        | references  | null: false, foreign_key : true     |
| prototype   | references  | null: false, foreign_key : true     |

### Association
 - belongs_to :user
 - belongs_to :prototype


## comments テーブル

| Column      | Type        | Options         |
| --------    | ------      | ---------       |
| text        | text        | null: false     |
| prototype   | references  |                 |
| user        | references  |                 |

### Association

- belongs_to :user
- belongs_to :prototype



