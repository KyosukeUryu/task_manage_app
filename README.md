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
