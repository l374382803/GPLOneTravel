//
//  GuanYuViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GuanYuViewController.h"
#import "RDVTabBarController.h"
#import "DGAaimaView.h"
@interface GuanYuViewController ()
{
    DGAaimaView *animaView;
}
@end

@implementation GuanYuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sc_navigationItem.title = @"关于";
    
    SCBarButtonItem *fanhui = [[SCBarButtonItem alloc]initWithTitle:@"返回" style:SCBarButtonItemStylePlain handler:^(id sender) {
        __weak typeof(self) weakSelf = self;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.sc_navigationItem.leftBarButtonItem = fanhui;
    
    animaView = [[DGAaimaView alloc]initWithFrame:CGRectMake(0, 64, Screen_Size.width, Screen_Size.height-64)];
    [self.view addSubview:animaView];
    
    [animaView DGAaimaView:animaView BigCloudSpeed:3 smallCloudSpeed:1 earthSepped:1.0 huojianSepped:1.5 littleSpeed:2];
    
    
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(Screen_Size.width/2-100 , Screen_Size.height/2+110, 200, 50)];
    la.text = @"即走旅行";
    la.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    la.font = [UIFont boldSystemFontOfSize:20];
    la.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:la];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 420,Screen_Size.width-40 , Screen_Size.height-420)];
    lab.text = @"生活因阅历而丰富,丰富的生活需要旅行来填充.即走旅行真诚为你服务.";
    lab.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:lab];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    /*
     创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    
    [UIView animateWithDuration:4.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        _icon.center = location; //CGPointMake(160, 284);
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
