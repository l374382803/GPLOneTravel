//
//  HomeModel.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeModel : JSONModel
@property (nonatomic,copy)NSString *headImage;
@property (nonatomic,copy)NSString *userHeadImg;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *routeDays;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *viewCount;
@property (nonatomic,copy)NSString *bookImgNum;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *text;
@end
