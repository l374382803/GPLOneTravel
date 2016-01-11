//
//  StarModelFrame.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "StarModelFrame.h"
@implementation StarModelFrame
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)setModel:(NewStarModel *)model
{
    _model = model;
    [self creatFrame];
}
- (void)creatFrame
{
    _iconFrame = CGRectMake(5, 5, 95, 185);
    _allFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+5, 5, 150, 30);
    _QFriendFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+5, 35, 150, 30);
    _loveFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+5, 65, 150, 30);
    _moneyFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+5, 95, 150, 30);
    _healthFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+5, 125, 150, 30);
    _colorFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+5, 155, 150, 30);
    NSString *sum = self.model.summary;
    CGSize maxSize = CGSizeMake(Screen_Size.width-10, CGFLOAT_MAX);
    CGSize StrSize = [sum boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kName_font} context:nil].size;
    _summaryFrame = CGRectMake(5, CGRectGetMaxY(_iconFrame), StrSize.width, StrSize.height+150);
    _cellHeigth = CGRectGetMaxY(_summaryFrame)+10;
}
@end
