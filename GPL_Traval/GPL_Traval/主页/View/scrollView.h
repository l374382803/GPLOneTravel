//
//  scrollView.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scrollView : UIView<SDCycleScrollViewDelegate>
@property (nonatomic,copy)void(^checkNew)(NSInteger index);
@end
