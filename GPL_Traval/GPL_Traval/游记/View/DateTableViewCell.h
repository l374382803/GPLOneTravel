//
//  DateTableViewCell.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesModel.h"
@interface DateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (nonatomic,strong)NotesModel *model;
@end
