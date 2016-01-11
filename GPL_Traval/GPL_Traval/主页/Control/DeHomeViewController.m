//
//  DeHomeViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DeHomeViewController.h"
#import "RDVTabBarController.h"
#import "DEhomeTableViewCell.h"
#import "StarView.h"
@interface DeHomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation DeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof (self) weakSelf = self;
    self.sc_navigationItem.title = @"详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    SCBarButtonItem *fanhui = [[SCBarButtonItem alloc]initWithTitle:@"返回" style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.sc_navigationItem.leftBarButtonItem = fanhui;
    [self creaTableView];

}
- (void)creaTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Size.width, Screen_Size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   // _tableView.rowHeight = 200;
   // _tableView.backgroundColor = [UIColor greenColor];
    _tableView.tableHeaderView = [self creatHeaderView:self.iconUrl];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (UIView *)creatHeaderView:(NSString *)path
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 64, Screen_Size.width, 300);
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    StarView *star = [[StarView alloc]init];
    star.frame = CGRectMake(CGRectGetMaxX(imageView.frame)-75, CGRectGetMaxY(imageView.frame)-31, 60, 30);
    CGFloat flot = (float)(arc4random()%2+3);
    [star setStar:flot];
    [imageView addSubview:star];
    [imageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [view addSubview:imageView];
    
    
    return view;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"热门线路";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEhomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEhomeTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[DEhomeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DEhomeTableViewCell"];
    }
   cell.textLabel.text = self.messageText;
    cell.textLabel.numberOfLines = 0;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize maxSize = CGSizeMake(Screen_Size.width-10, CGFLOAT_MAX);
    NSString *textStr = self.messageText;
    CGSize StrSize = [textStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kName_font} context:nil].size;
    return StrSize.height+50;

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
