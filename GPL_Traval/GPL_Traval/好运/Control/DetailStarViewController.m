//
//  DetailStarViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DetailStarViewController.h"
#import "RDVTabBarController.h"
#import "downLoad.h"
#import "StarTableViewCell.h"
#import "NewStarModel.h"
#import "StarModelFrame.h"
@interface DetailStarViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    UIImageView *backImageView;
    NSMutableArray *dataArray;
}
@end
//http://web.juhe.cn:8080/constellation/getAll?consName=%E7%8B%AE%E5%AD%90%E5%BA%A7&type=today&key=申请的KEY
@implementation DetailStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof (self) weakSelf = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    imageview.image = [UIImage imageNamed:@"title"];
    imageview.clipsToBounds = YES;
    imageview.layer.cornerRadius = 35;
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:imageview];
    self.sc_navigationItem.titleView = view;
    //self.sc_navigationItem.title = @"星座";
    self.automaticallyAdjustsScrollViewInsets = NO;
    dataArray = [[NSMutableArray alloc]init];
    [self getData];
    SCBarButtonItem *fanhui = [[SCBarButtonItem alloc]initWithTitle:@"返回" style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:NO];
    }];
    self.sc_navigationItem.leftBarButtonItem = fanhui;
    
    backImageView = [[UIImageView alloc]init];
    backImageView.frame = CGRectMake(0, 64, Screen_Size.width, Screen_Size.height-64);
    UIImage *im = [UIImage imageNamed:@"starback"];
    backImageView.image = im;
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    [self creatTableView];
    
}
- (void)getData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [downLoad downLoadWithType:downLoadTypeGET downLoadWithPath:self.nameStr parameter:nil success:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@",dict);
        NewStarModel *model = [[NewStarModel alloc]initWithDictionary:dict error:nil];
        StarModelFrame *frame = [[StarModelFrame alloc]init];
        frame.model = model;
        
        [dataArray addObject:frame];
        [_tableview reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (void)creatTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Size.width, Screen_Size.height-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.alpha = 0.8;
    
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[StarTableViewCell class] forCellReuseIdentifier:@"StarTableViewCell"];
    [backImageView addSubview:_tableview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"123456";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    StarModelFrame *starFram = dataArray[section];
    
    UILabel *la = [[UILabel alloc]init];
    NSString *tit = [NSString stringWithFormat:@"星座:%@  时间%@",starFram.model.name,starFram.model.datetime];
    la.text = tit;
    la.textColor = [UIColor redColor];
    la.font = [UIFont boldSystemFontOfSize:20];
    return la;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    StarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarTableViewCell"];
    StarModelFrame *starFram = dataArray[indexPath.row];
    cell.modelFrame = starFram;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StarModelFrame *starFram = dataArray[indexPath.row];
    return starFram.cellHeigth;
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
