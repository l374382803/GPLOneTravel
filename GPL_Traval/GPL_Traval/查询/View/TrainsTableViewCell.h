//
//  TrainsTableViewCell.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainModel.h"
@interface TrainsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *star;
@property (weak, nonatomic) IBOutlet UILabel *end;


@property (weak, nonatomic) IBOutlet UILabel *trainnum;

@property (weak, nonatomic) IBOutlet UILabel *starTime;

@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UILabel *startlable;

@property (weak, nonatomic) IBOutlet UILabel *terminal;

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *pricelist;
@property (nonatomic,retain)TrainModel *trainModel;
@end
