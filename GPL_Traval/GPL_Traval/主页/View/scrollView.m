//
//  scrollView.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "scrollView.h"

@implementation scrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatui];
    }
    return self;
}
- (void)creatui
{
    NSArray *imagesURLStrings = @[
                                  @"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=3379b1922f2eb938f86072a0b40bee50/d043ad4bd11373f0e59cddeca40f4bfbfbed0425.jpg",
                                  @"http://d.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=7bc307ccbc3eb13550cabfe9c777c3b6/267f9e2f07082838e4f9f730b899a9014c08f11a.jpg",
                                  @"http://e.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=7c914be72bf5e0fefa1581533d095fcd/cefc1e178a82b901c61e87cd758da9773812ef99.jpg",
                                  @"http://c.hiphotos.baidu.com/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=7cbfe340b4003af359b7d4325443ad39/7aec54e736d12f2ef354ad294dc2d56285356821.jpg"
                                  ];
    NSArray *titles = @[@"蓝白交织的童话世界--爱琴海",
                        @"浪漫之都--巴黎",
                        @"秀美中国,人间天堂--丽江",
                        @"千年古镇,历史瑰宝--周庄"
                        ];
    CGFloat w = self.frame.size.width;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,w, 150) imagesGroup:nil];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.delegate = self;
    cycleScrollView.titlesGroup = titles;
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder.png"];
    cycleScrollView.dotColor = WColorRGB(107, 194, 53);
    
    
    [self addSubview:cycleScrollView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    self.checkNew(index);
}


@end
