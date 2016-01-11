//
//  SearchViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "SearchViewController.h"
//#import "downLoad.h"
//#import "NSString+URLEncoding.h"
#import "TrainViewController.h"
//http://www.tuling123.com/openapi/api?key=KEY&info=北京中关村附近的酒店
@interface SearchViewController ()
{
    UITextField *_textFiled;
    UITextField *_endtextField;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sc_navigationItem.title = @"查询";
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.frame = CGRectMake(0, 64, Screen_Size.width, Screen_Size.height);
    backImageView.userInteractionEnabled = YES;
    UIImage *im = [UIImage imageNamed:@"Default"];
    backImageView.image = im;
    [self.view addSubview:backImageView];
    
    UIView *view = [[UIView alloc]init];
    if (Screen_Size.height>500) {
    view.frame = CGRectMake(20, 100, Screen_Size.width-40, Screen_Size.width-80);
    }else{
    view.frame = CGRectMake(20, 80, Screen_Size.width-40, Screen_Size.height/3-5);
    }
    view.layer.cornerRadius = 10;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    _textFiled = [[UITextField alloc]init];
    _textFiled.frame = CGRectMake(10, 20, view.frame.size.width-20, (view.frame.size.height-50)/4);
    
    _textFiled.placeholder = @"起始地";
    _textFiled.clearButtonMode = UITextFieldViewModeAlways;
    _textFiled.layer.borderWidth = 1;
    _textFiled.layer.cornerRadius = 5;
    [view addSubview:_textFiled];
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_textFiled.frame)+10,view.frame.size.width-20, (view.frame.size.height-50)/4-20)];
    la.text = @"到";
    la.font = [UIFont boldSystemFontOfSize:20];
    la.alpha = 1;
    la.textAlignment = NSTextAlignmentCenter;
    la.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    [view addSubview:la];
    
    _endtextField = [[UITextField alloc]init];
    _endtextField.frame = CGRectMake(10, CGRectGetMaxY(la.frame)+10, view.frame.size.width-20, (view.frame.size.height-50)/4);
    _endtextField.clearButtonMode = UITextFieldViewModeAlways;
    _endtextField.layer.cornerRadius = 5;
    _endtextField.layer.borderWidth = 1;
    _endtextField.placeholder = @"目的地";
    [view addSubview:_endtextField];
    
    UIButton *bu = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width/2-(view.frame.size.width-20)/4, CGRectGetMaxY(_endtextField.frame)+10, (view.frame.size.width-20)/2, (view.frame.size.height-50)/4)];
    [bu addTarget:self action:@selector(buclicknow) forControlEvents:UIControlEventTouchUpInside];
    [bu setTitleColor:[UIColor colorWithRed:0.745 green:0.651 blue:0.439 alpha:1.000] forState:UIControlStateHighlighted];
    [bu setTitle:@"查询" forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor colorWithRed:1.000 green:0.771 blue:0.164 alpha:1.000]];
    [view addSubview:bu];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _textFiled.text = nil;
    _endtextField.text = nil;
}
- (void)buclicknow
{
    if (_textFiled.text.length > 0&&_endtextField.text.length > 0) {
        
        NSString *path = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/train/query_ab?from=%@&to=%@&key=8de4f3370af69aed395538a3f3b9cd1f",_textFiled.text,_endtextField.text];
        NSLog(@"%@",path);
        TrainViewController *train = [[TrainViewController alloc]init];
        train.path = path;
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:train];
        [self presentViewController:nvc animated:YES completion:nil];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
