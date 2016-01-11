//
//  MessageSQL.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MessageSQL.h"
static MessageSQL * instance = nil;
@implementation MessageSQL

+(instancetype) shareInstance
{
    static dispatch_once_t token = 0;
    
    //多线程下单例，保证实例化的代码只执行一次
    dispatch_once(&token, ^{
        instance = [[MessageSQL alloc] init];
        
        //打开数据库
        if ([instance creatSql]==NO) {
            instance= nil;
        }else{
            [instance creatSqlList];
        }
    });
    return instance;

}
- (BOOL)creatSql
{
    //数据文件的在Documents下的路径
    NSString* documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/note.sqlite"];
    _base = [FMDatabase databaseWithPath:documentPath];
    
    //数据库打开失败
    if([_base open]==NO){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"数据库打开失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return YES;

}
- (void)creatSqlList
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if ([ud valueForKey:@"isFirstRun"]==nil) {
        //创建表
        NSString *sql = @"create table note(ndate text primary key,content text);";
        BOOL rect = [_base executeUpdate:sql];
        if (rect) {
            NSLog(@"表单创建成功");
        }
        //给isFirstRun键赋值
        [ud setObject:@"1" forKey:@"isFirstRun"];
    }

}
- (void)addMessage:(NSString *)message andDate:(NSString *)dateStr
{
    if ([self searchMessage:message]) {
        NSLog(@"yi cunzai ");
    }else{
    NSString * sql = [NSString stringWithFormat:@"insert into note values('%@','%@')",message,dateStr];
    BOOL rect = [_base executeUpdate:sql];
    if (rect) {
        NSLog(@"插入成功");
        self.rect = rect;
        }
    }
}
- (BOOL)searchMessage:(NSString *)text
{
    NSString *sql = @"select * from note where content = ?;";
    FMResultSet *set = [_base executeQuery:sql,text];
    while ([set next]) {
        
    }
    Boolean fl = set.next;
    return fl;
}
- (void)delegateData:(NSString *)text
{
     NSString *sql = @"delete from note where ndate = ?;";
    BOOL ret = [_base executeUpdate:sql,text];
    if (ret == YES) {
        NSLog(@"删除成功");
    }
}
- (NSMutableArray *)getAllData
{
    NSMutableArray * array = [NSMutableArray new];
    
    NSString * sql = @"select * from note order by nDate desc;";
    FMResultSet * set = [_base executeQuery:sql];
    while ([set next]) {
        NSString *date = [set stringForColumn:@"ndate"];
        NSString *str = [set stringForColumn:@"content"];
        NotesModel *mo = [[NotesModel alloc]init];
        mo.dateString = date;
        mo.noteString = str;
        [array addObject:mo];
    }
    

    return array;
}
@end
