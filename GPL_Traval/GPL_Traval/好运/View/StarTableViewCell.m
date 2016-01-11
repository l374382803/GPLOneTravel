//
//  StarTableViewCell.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "StarTableViewCell.h"
#import "StarView.h"
@implementation StarTableViewCell
{
    UIImageView *iconView;
    StarView *allView;
    UILabel *QFriendLable;
    UILabel *colorLable;
    UILabel *healthLable;
    UILabel *moneyLable;
    UILabel *loveLable;
    UILabel *summaryLable;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
}
- (void)creatCell
{
    iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:@"image2.jpg"];
    [self.contentView addSubview:iconView];
    
    allView = [[StarView alloc]init];
    [self.contentView addSubview:allView];
    
    QFriendLable = [[UILabel alloc]init];
    QFriendLable.textColor = WColorRGB(100, 45, 60);
    QFriendLable.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:QFriendLable];
    
    colorLable = [[UILabel alloc]init];
    colorLable.textColor = WColorRGB(150, 85, 60);
    colorLable.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:colorLable];
    
    healthLable = [[UILabel alloc]init];
    healthLable.textColor = WColorRGB(10, 45, 60);
    healthLable.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:healthLable];
    
    moneyLable = [[UILabel alloc]init];
    moneyLable.textColor = WColorRGB(50, 145, 60);
    moneyLable.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:moneyLable];
    
    loveLable = [[UILabel alloc]init];
    loveLable.textColor = WColorRGB(100, 120, 60);
    loveLable.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:loveLable];

    summaryLable = [[UILabel alloc]init];
    summaryLable.textColor = [UIColor colorWithRed:0.237 green:0.878 blue:1.000 alpha:1.000];
    summaryLable.font = [UIFont boldSystemFontOfSize:22];
    summaryLable.numberOfLines = 0;
    summaryLable.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:summaryLable];
    
}
- (void)setModelFrame:(StarModelFrame *)modelFrame
{
    _modelFrame = modelFrame;
    NewStarModel *mo = modelFrame.model;
    iconView.frame = modelFrame.iconFrame;
    
    CGFloat fl = [mo.all floatValue]*5;
    [allView setStar:fl];
    allView.frame = modelFrame.allFrame;
    QFriendLable.frame = modelFrame.QFriendFrame;
    QFriendLable.text = mo.QFriend;
    healthLable.frame = modelFrame.healthFrame;
    healthLable.text = [NSString stringWithFormat:@"健康指数:%@",mo.health];
    moneyLable.frame = modelFrame.moneyFrame;
    moneyLable.text = [NSString stringWithFormat:@"财运指数:%@",mo.money];
    
    colorLable.frame = modelFrame.colorFrame;
    colorLable.text = [NSString stringWithFormat:@"幸运色:%@",mo.color];
    
    loveLable.frame = modelFrame.loveFrame;
    loveLable.text = [NSString stringWithFormat:@"桃花运:%@",mo.love];
    
    summaryLable.frame = modelFrame.summaryFrame;
    
    summaryLable.text = [NSString stringWithFormat:@"Summary :%@",mo.summary];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
