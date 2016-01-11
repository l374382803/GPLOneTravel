//
//  DateTableViewCell.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DateTableViewCell.h"

@implementation DateTableViewCell
- (void)setModel:(NotesModel *)model
{
    _model = model;
    _dateLable.text = model.noteString;
    _textLable.text = model.dateString;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
