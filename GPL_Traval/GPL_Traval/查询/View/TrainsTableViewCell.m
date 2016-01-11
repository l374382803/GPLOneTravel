//
//  TrainsTableViewCell.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "TrainsTableViewCell.h"

@implementation TrainsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setTrainModel:(TrainModel *)trainModel
{
    _trainModel = trainModel;
    _starTime.text = trainModel.start_time;
    _endTime.text = trainModel.end_time;
    _icon.image = [UIImage imageNamed:@"TencentWeixinFriend"];
    _startlable.text = trainModel.start_station;
    _trainnum.text = trainModel.train_type;
    _terminal.text = trainModel.end_station;
    NSMutableArray *array = [NSMutableArray new];
    for (NSDictionary *dic in trainModel.price_list) {
        NSString *type = dic[@"price_type"];
        NSString *price = dic[@"price"];
        NSString *str = [NSString stringWithFormat:@"%@:%@￥",type,price];
        [array addObject:str];
    }
    NSString *allstring = [NSString stringWithFormat:@"%@  %@",array[0],array[1]];
    [array removeAllObjects];
    _pricelist.text = allstring;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
