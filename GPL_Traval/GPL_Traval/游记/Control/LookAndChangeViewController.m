//
//  LookAndChangeViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "LookAndChangeViewController.h"
#import "MessageSQL.h"
#import "RDVTabBarController.h"
@interface LookAndChangeViewController ()<UITextViewDelegate>
{
    UITextView *_textView;
    UILabel *_backLable;
}
@end

@implementation LookAndChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    self.sc_navigationItem.title = @"查看";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    SCBarButtonItem *fanhui = [[SCBarButtonItem alloc]initWithTitle:@"返回" style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    self.sc_navigationItem.leftBarButtonItem = fanhui;
//    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [saveButton setTitle:@"编辑" forState:UIControlStateNormal];
//    [saveButton addTarget:self action:@selector(changeMessage) forControlEvents:UIControlEventTouchUpInside];
//    self.sc_navigationItem.rightBarButtonItem = [[SCBarButtonItem alloc]initWithCustomView:saveButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘将要消失时触发的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide:) name:UIKeyboardWillHideNotification object:nil];
    [self creatNotes];
}
- (void)changeMessage
{
    
}
- (void)creatNotes
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 64, Screen_Size.width-10, Screen_Size.height)];
    _textView.alpha = 1;
    _textView.font = [UIFont boldSystemFontOfSize:15];
    _textView.text = _text;
    _textView.delegate = self;
    _backLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Size.width-10, 60)];
    _backLable.center = _textView.center;
    _backLable.backgroundColor = [UIColor colorWithRed:0.875 green:0.971 blue:1.000 alpha:1.000];
    _backLable.textColor = [UIColor colorWithRed:1.000 green:0.937 blue:0.513 alpha:1.000];
    _backLable.text = @"点击这里可以收键盘呦！！";
    _backLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_backLable];
    [self.view insertSubview:_textView aboveSubview:_backLable];
}
- (void)show:(NSNotification *)noti
{
    // 打印键盘的信息
    //NSLog(@"********%@", noti.userInfo);
    // rect 获取到键盘的高度
    CGRect rect = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = rect.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        CGRect lab = _backLable.frame;
        lab.origin.y = Screen_Size.height-height-60;
        _backLable.frame = lab;
        CGRect rect = _textView.frame;
        rect.size.height = Screen_Size.height-height-60-64;
        _textView.frame = rect;
        
    } completion:^(BOOL finished) {
        NSLog(@"Finish");
    }];
    
}
- (void)hide:(NSNotification *)noti
{
    [UIView animateWithDuration:0.5 animations:^{
        // 重置了view的frame
        CGRect rect = _textView.frame;
        rect.size.height = Screen_Size.height;
        _textView.frame = rect;
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
