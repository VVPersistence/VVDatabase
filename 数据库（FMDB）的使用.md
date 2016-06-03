
#     数据库（FMDB）的使用
示例：创建一个Student表
首先要获得Document路径

    #define FilePath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
 然后获得详细的路径
 

    #define DataBasePath [FilePath stringByAppendingPathComponent:@"Student.sqlite"]
 1，创建数据库对象（db）

    if (!_db) {
        //创建数据库
        self.db = [FMDatabase databaseWithPath:DataBasePath];
    }
    return _db;

2，在数据库中创建一张Student表

    //1，打开数据库
    [self.db open];
    //2,在数据库中创建一张表
    BOOL result = [self.db executeUpdate:@"create table if not exists Students(stu_id integer primary key autoincrement,stu_name text,stu_gender text,stu_age integer)"];
    if (result) {
        NSLog(@"表创建成功 %@", DataBasePath);
    }
    //3，关闭数据库
    [self.db close];


注意：FMDB在执行数据插入或查询， 删除， 更新的时候，操作的数据必须是对象类型的数据。
3，增加数据

    //1,打开数据库
    [self.db open];
    //2,插入数据
    BOOL result = [self.db executeUpdate:@"insert into Students(stu_name,stu_gender,stu_age)values(?,?,?)", self.nameT.text,self.genderT.text, @(self.ageT.text.integerValue)];
    if (result) {
        NSLog(@"插入数据成功 %@", DataBasePath);
    }
    //关闭数据库
    [self.db close];
4,删除数据

     //1,打开数据库
    [self.db open];
    //2,删除数据
    BOOL result = [self.db executeUpdate:@"delete from Students where stu_id = ？", @(self.ageT.text.integerValue)];
    if (result) {
        NSLog(@"删除数据成功 %@", DataBasePath);
    }
    //关闭数据库
    [self.db close];
5，查找数据

    //1,打开数据库
    [self.db open];
    //开始查找数据
    FMResultSet *set = [self.db executeQuery:@"select *from Students where stu_age = ?", @(self.ageT.text.integerValue)];
    //set next 返回一个BOOL 类型的数
    while ([set next]) {
        NSLog(@"%d, %@, %@, %d", [set intForColumnIndex:0], [set stringForColumnIndex:1], [set stringForColumnIndex:2], [set intForColumnIndex:3]);
    }
    //关闭数据库
    [self.db close];
6，更新数据

    //1,打开数据库
    [self.db open];
    //2,更新数据
    BOOL result = [self.db executeUpdate:@"update Students set stu_name = '霓凰',stu_age = 20 where stu_id = 3"];
    if (result) {
        NSLog(@"更新数据成功 %@", DataBasePath);
    }
    //关闭数据库
    [self.db close];
## 创建数据库SQLite语句
//创建表的SQL语句 （Students表）
create table if not exists Students(stu_id integer primary key autoincrement,stu_name text,stu_gender text,stu_age integer)
integer  整型。      text 字符串。
primary key 主键，区分每一条数据的依据，因此不能相同。
autoincrement 自主增长，修饰的属性在每一次增加数据的时候值都会加1。
每个属性用逗号分开。
Run SQL 测试语句。

//插入数据的SQL语句
insert into Students(stu_name,stu_gender,stu_age)values('琅琊','男',22)
字符串用单引号或者双引号（英文符号）

//更新修改数据的SQL语句
update Students set stu_name = '霓凰',stu_age = 20 where stu_id = 3
where 指的是在那个地方

//查找所有数据
select * from Students
*代表所有属性列表的内容

//查找指定的属性
select stu_name,stu_gender from Students

//查询指定的人的所有属性
select *from Students where stu_id = 1

//删除一条数据的SQL语句
delete from Students where stu_id = 2

//删除表
drop Table Students

 

    


   
  