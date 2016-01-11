//
//  detailFrame.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "detailCellModel.h"
@interface detailFrame : NSObject
@property (nonatomic,strong)detailCellModel *detailcellmodel;
@property (nonatomic)CGRect imageFrame;
@property (nonatomic)CGRect textFrame;
@property (nonatomic)CGFloat cellHeight;
@end
