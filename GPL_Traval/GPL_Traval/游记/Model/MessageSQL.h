//
//  MessageSQL.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "NotesModel.h"
@interface MessageSQL : NSObject
@property (nonatomic,strong)FMDatabase *base;
@property(nonatomic)BOOL rect;
+(instancetype) shareInstance;
- (void)addMessage:(NSString *)message andDate:(NSString *)dateStr;
- (NSMutableArray *)getAllData;
- (void)delegateData:(NSString *)text;
@end
