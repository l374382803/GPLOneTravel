//
//  Pricelist.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Pricelist : JSONModel
@property (nonatomic,copy)NSString*price;
@property (nonatomic,copy)NSString*price_type;
@end
 