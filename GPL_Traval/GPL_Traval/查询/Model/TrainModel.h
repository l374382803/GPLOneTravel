//
//  TrainModel.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Pricelist.h"
@interface TrainModel : JSONModel
@property (nonatomic,copy)NSString *train_type;
@property (nonatomic,copy)NSString *end_station;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *m_train_url;
@property (nonatomic,copy)NSString *start_station;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,strong)NSArray<Pricelist *>*price_list;
@end
