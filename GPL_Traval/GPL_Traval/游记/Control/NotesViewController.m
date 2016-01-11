//
//  NotesViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "NotesViewController.h"
#import "RDVTabBarController.h"
#import "MessageSQL.h"
@interface NotesViewController ()<UITextViewDelegate>
{
    UITextView *_textView;
    UILabel *_backLable;
}
@end

@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    self.sc_navigationItem.title = @"记笔记";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    SCBarButtonItem *fanhui = [[SCBarButtonItem alloc]initWithTitle:@"返回" style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    self.sc_navigationItem.leftBarButtonItem = fanhui;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [saveButton addTarget:self action:@selector(saveMessage) forControlEvents:UIControlEventTouchUpInside];
    self.sc_navigationItem.rightBarButtonItem = [[SCBarButtonItem alloc]initWithCustomView:saveButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    
    // 键盘将要消失时触发的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide:) name:UIKeyboardWillHideNotification object:nil];
    [self creatNotes];
}
- (void)saveMessage
{
    NSDateFormatter *  df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString * nDate = [df stringFromDate:[NSDate date]];
    if (_textView.text.length <= 0) {
        UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"提示" message:@"内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alt animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });

    }else{
        MessageSQL *mesql = [MessageSQL shareInstance];
        [mesql addMessage:_textView.text andDate:nDate];
       // NSLog(@"^^^^^^^^^^^%d",mesql.rect);
        if (mesql.rect) {
            UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alt animated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });

        }
    }
}

- (void)creatNotes
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 64, Screen_Size.width-10, Screen_Size.height)];
    _textView.alpha = 1;
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, Screen_Size.width, 50)];
    la.tag = 12;
    la.text = @"请输入你想要记录的内容O(∩_∩)O~~";
    [_textView addSubview:la];
    _textView.font = [UIFont boldSystemFontOfSize:15];
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
    UILabel *la = (id)[self.view viewWithTag:12];
    la.alpha = 0;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    UILabel *la = (id)[self.view viewWithTag:12];
    if (textView.text.length > 0) {
        la.alpha = 0;
    }else{
        la.alpha = 1;
    }
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
