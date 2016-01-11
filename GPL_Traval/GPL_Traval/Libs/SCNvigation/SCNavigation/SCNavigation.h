//
//  SCNavigation.h
//  HuaRenJie
//
//  Created by snow on 7/7/15.
//  Copyright (c) 2015 GuangWei. All rights reserved.
//

#ifndef __WNavigationController__
#define __WNavigationController__
#import "Log.h"
#import "SCNavigationController.h"
#import "SCNavigationBar.h"
#import "SCNavigationItem.h"
#import "SCBarButtonItem.h"
#import "WViewController.h"

static NSInteger const WPeddingWidth = 16;
static NSInteger const WRightPedding = -8;
static CGFloat const WBlurRadius = 25.0f;
//title字体大小
#define KNavigationBarTitleFont 18
//button的字体大小
#define KNavigationBarItemTitleFont 18

//导航栏上的title和button的字体颜色
#define kNavigationBarTintColor [UIColor whiteColor]

//导航栏的颜色
#define kNavigationBarColor     WColorRGB(131, 175, 155);

//导航栏下边界的线条的颜色
#define kNavigationBarLineColor [UIColor colorWithWhite:0.869 alpha:1]

#endif