//
//  HomeDetailTableViewCell.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeDetailTableViewCell : UITableViewCell
@property (nonatomic,strong)HomeModel *hoModel;
@property (nonatomic,strong)UIImageView *backImageView;
@property (nonatomic,strong)UIImageView *userImageView;
@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *allLable;
@end
