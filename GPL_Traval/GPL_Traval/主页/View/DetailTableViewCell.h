//
//  DetailTableViewCell.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailFrame.h"
@interface DetailTableViewCell : UITableViewCell
@property (nonatomic,strong)detailFrame *detaFram;
@property (nonatomic,strong)UIImageView *deimageView;
@property (nonatomic,strong)UILabel *textLable;
@end
