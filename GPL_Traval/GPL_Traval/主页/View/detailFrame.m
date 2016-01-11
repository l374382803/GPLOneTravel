//
//  detailFrame.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "detailFrame.h"

@implementation detailFrame
- (void)setDetailcellmodel:(detailCellModel *)detailcellmodel
{
    _detailcellmodel = detailcellmodel;
    _imageFrame = CGRectMake(5, 5, Screen_Size.width-10, 210);
    CGSize maxSize = CGSizeMake(Screen_Size.width-10, CGFLOAT_MAX);
    NSString *textStr = _detailcellmodel.textStr;
    CGSize StrSize = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kName_font} context:nil].size;
    _textFrame = CGRectMake(5, CGRectGetMaxY(_imageFrame)+2, StrSize.width, StrSize.height);
    _cellHeight = CGRectGetMaxY(_textFrame)+5;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
@end
