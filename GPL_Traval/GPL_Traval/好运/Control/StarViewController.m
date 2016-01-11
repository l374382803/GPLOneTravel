//
//  StarViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "StarViewController.h"
#import "DBSphereView.h"
#import "DetailStarViewController.h"
#import "NSString+URLEncoding.h"

#import "downLoad.h"
@interface StarViewController ()
@property (nonatomic, retain) DBSphereView *sphereView;
@end

@implementation StarViewController
@synthesize sphereView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sc_navigationItem.title = @"星运";
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.frame = CGRectMake(0, 64, Screen_Size.width, Screen_Size.height-109);
    UIImage *im = [UIImage imageNamed:@"005.jpg"];
    backImageView.image = im;
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    
    
    sphereView = [[DBSphereView alloc]init];
    sphereView.frame = CGRectMake(15, 90, backImageView.frame.size.width-30,backImageView.frame.size.width-30);
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
 NSArray *nbaArray=@[@"star1",@"star2",@"star3",@"star4",@"star5",@"star6",@"star7",@"star8",@"star9",@"star10",@"star11",@"star12"];
    
    for (NSInteger i = 0; i < nbaArray.count; i ++) {
       UIImageView *im = [[UIImageView alloc]init];
        im.frame = CGRectMake(0, 0, 100, 100);
        im.backgroundColor = [UIColor redColor];
        im.layer.cornerRadius = 50;
        im.tag = 10+i;
        im.image = [UIImage imageNamed:nbaArray[i]];
        im.clipsToBounds = YES;
        UIButton *button = [[UIButton alloc]init];
        button.tag = 30+i;
        button.frame = CGRectMake(0, 0, 100, 100);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [im addSubview:button];
        [array addObject:im];
        [sphereView addSubview:im];
        
    }
    
    [sphereView setCloudTags:array];
    sphereView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:sphereView];
    
    
}
-(void)buttonClick:(UIButton *)bu
{
    NSArray *nameArray = @[@"射手座",@"巨蟹座",@"双鱼座",@"狮子座",@"金牛座",@"双子座",@"白羊座",@"天蝎座",@"天秤座",@"水瓶座",@"处女座",@"摩羯座",];
    NSInteger te = bu.tag-30;
    NSString *str = nameArray[te];
    NSString *pathstr = [NSString stringWithFormat:@"http://web.juhe.cn:8080/constellation/getAll?consName=%@&type=today&key=75f417b83c0b6e5e3ae1543ed638dfd9",str];
    NSString *path = [pathstr URLEncodedString];
        /*http://web.juhe.cn:8080/constellation/getAll
     请求参数：consName=%E7%99%BD%E7%BE%8A%E5%BA%A7&type=today&key=75f417b83c0b6e5e3ae1543ed638dfd9
     请求方式：GET*/
    [sphereView timerStop];
    UIImageView *image = (id)[self.view viewWithTag:bu.tag-20];
    [UIView animateWithDuration:0.6 animations:^{
        image.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            image.transform = CGAffineTransformMakeScale(1., 1.);//缩放功能
        } completion:^(BOOL finished) {
            [sphereView timerStart];
        }];
        
        DetailStarViewController *de = [[DetailStarViewController alloc]init];
        de.nameStr = path;
        [self.navigationController pushViewController:de animated:YES];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
