//
//  SCNavigationItem.h
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCBarButtonItem;
@interface SCNavigationItem : NSObject

@property (nonatomic, strong  ) SCBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong  ) SCBarButtonItem *rightBarButtonItem;
@property (nonatomic, copy    ) NSString        *title;

@property (nonatomic, strong  ) UIView          *titleView;

@end
