//
//  HomeDetailTableViewCell.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HomeDetailTableViewCell.h"

@implementation HomeDetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _backImageView = [[UIImageView alloc]init];
        
        _backImageView.layer.cornerRadius = 5;
        _backImageView.frame = CGRectMake(5, 5, Screen_Size.width-10, 200);
        [self.contentView addSubview:_backImageView];
        _titleLable = [[UILabel alloc]init];
        
        _titleLable.numberOfLines = 0;
        _titleLable.frame = CGRectMake(5, 5, Screen_Size.width-20, 50);
        _titleLable.font = [UIFont boldSystemFontOfSize:18];
        _titleLable.textColor = [UIColor whiteColor];
        [_backImageView addSubview:_titleLable];
        _userImageView = [[UIImageView alloc]init];
        
        _userImageView.frame = CGRectMake(8, CGRectGetMaxY(_backImageView.frame)+3, 60, 60);
        _userImageView.layer.cornerRadius = 30;
        _userImageView.clipsToBounds = YES;
        [self.contentView addSubview:_userImageView];
        _nameLable = [[UILabel alloc]init];
        
        _nameLable.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+5, CGRectGetMaxY(_backImageView.frame)+3, 200, 27);
        [self.contentView addSubview:_nameLable];
        _allLable = [[UILabel alloc]init];
        
        
        _allLable.frame = CGRectMake(CGRectGetMaxX(_userImageView.frame)+5, CGRectGetMaxY(_nameLable.frame)+2, Screen_Size.width-CGRectGetMaxX(_userImageView.frame)+5, 27);
        
        
        [self.contentView addSubview:_allLable];
    }
    return self;
}
- (void)setHoModel:(HomeModel *)hoModel
{
    _hoModel = hoModel;
    [self.backImageView setImageWithURL:[NSURL URLWithString:hoModel.headImage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLable.text = hoModel.title;
    [self.userImageView setImageWithURL:[NSURL URLWithString:hoModel.userHeadImg] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.nameLable.text = hoModel.userName;
    NSString *str = [NSString stringWithFormat:@"☼:%@/%@天/订:%@/%@",hoModel.startTime,hoModel.routeDays,hoModel.bookImgNum,hoModel.viewCount];
    self.allLable.text = str;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
