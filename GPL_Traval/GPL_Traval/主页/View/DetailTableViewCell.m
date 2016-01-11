//
//  DetailTableViewCell.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)setDetaFram:(detailFrame *)detaFram
{
    _detaFram = detaFram;
    detailCellModel *model = detaFram.detailcellmodel;
    [_deimageView setImageWithURL:[NSURL URLWithString:model.iconStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _deimageView.frame = detaFram.imageFrame;
    _textLable.text = model.textStr;
    _textLable.frame = detaFram.textFrame;
}
- (void)creatUI
{
    _deimageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_deimageView];
    _textLable = [[UILabel alloc]init];
    _textLable.numberOfLines = 0;
    _textLable.lineBreakMode = NSLineBreakByCharWrapping;
    _textLable.font = [UIFont systemFontOfSize:15];
    _textLable.textColor = [UIColor colorWithRed:0.897 green:0.409 blue:1.000 alpha:1.000];
    [self.contentView addSubview:_textLable];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
