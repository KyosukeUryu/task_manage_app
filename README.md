## herokuデプロイ手順
***
|No|内容|
|:---|:---|
|1|heroku loginにてログイン|
|2|heroku createにてアプリ作成|
|3|git push heroku masterでデプロイ|
|4|heroku run rails db:migrateでマイグレーション実施|

## 各種バージョン
***
### ruby 2.6.5

### Rails 5.2.3

### psql (PostgreSQL) 11.5

***

## テーブル概要


**User**

|column|type|
|:---|:---|
|name|string|
|email|string|
|password_digest|string|

**Task**

|column|type|
|:---|:---|
|name |string|
|description|text|
|status|integer|
|priority|integer|
|dead_line|datetime|

**Labelling**

|column|type|
|:---|:---|
|task|references|
|label|references|

**Label**

|column|type|
|:---|:---|
|name|string|
