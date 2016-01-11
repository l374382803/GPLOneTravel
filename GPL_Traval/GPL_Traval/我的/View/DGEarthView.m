//
//  DGEarthView.m
//  animaByIdage
//
//  Created by chuangye on 15-3-11.
//  Copyright (c) 2015年 chuangye. All rights reserved.
//

#import "DGEarthView.h"

@implementation DGEarthView

{
    double angleEarth;
    double angle;
    UIImageView *imageView;
    UIImageView *imageViewEarth;
    NSMutableArray *imageArray;
    int value;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _EarthSepped=1.0;
        _huojiansepped=2.0;
        value=1;
        self.backgroundColor=[UIColor clearColor];
        imageArray = [[NSMutableArray alloc]init];
        
            //地球位置
        imageViewEarth = [[UIImageView alloc]initWithFrame:CGRectMake(31, 160, 260, 260)];
        imageViewEarth.image=[UIImage imageNamed:@"earth@3x"];
        [self addSubview:imageViewEarth];
        
            //小火箭位置
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(150, 260, 30, 60)];
        [self addSubview:imageView];
        imageView.image=[UIImage imageNamed:@"fire2@3X(1)"];
        
        [self startAnimation];
        [self startAnimationEarth];
        
    }
    return self;
}

    //火箭动画
-(void) startAnimation
{
    NSString *imageName;
    if (value>=3) {
        
        value=1;
    }
    imageName = [NSString stringWithFormat:@"fire%d@3X(1)",value];
    
    imageView.image = [UIImage imageNamed:imageName];
    value++;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    imageView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    imageView.layer.anchorPoint=CGPointMake(5, 0.5);
    [UIView commitAnimations];
    
    
    
}
-(void)endAnimation
{
        //改变火箭速度
    angle += 5*_huojiansepped;
    [self startAnimation];
    
    
}
    //地球动画
-(void) startAnimationEarth
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimationEarth)];
    imageViewEarth.transform = CGAffineTransformMakeRotation(angleEarth * (M_PI / -180.0f));
     [UIView commitAnimations];
}
-(void)endAnimationEarth
{
        //改变地球速度
    angleEarth += 30*_EarthSepped;
    [self startAnimationEarth];
    
}



@end
