#Users table
```
name:string
email:string
password_digest:string
```

#Tasks table
```
name:string
description:text
status:integer
priority:integer
dead_line:datetime
user:references
```

#Labellings table
```
task:references
label:references
```

#labels table
```
name:string
```
