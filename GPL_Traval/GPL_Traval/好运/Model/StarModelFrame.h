//
//  StarModelFrame.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewStarModel.h"
@interface StarModelFrame : NSObject
@property (nonatomic ,strong)NewStarModel *model;
@property (nonatomic)CGRect QFriendFrame;
@property (nonatomic)CGRect iconFrame;
@property (nonatomic)CGRect allFrame;
@property (nonatomic)CGRect colorFrame;
@property (nonatomic)CGRect healthFrame;
@property (nonatomic)CGRect loveFrame;
@property (nonatomic)CGRect moneyFrame;
@property (nonatomic)CGRect summaryFrame;
@property (nonatomic)CGFloat cellHeigth;
@end
