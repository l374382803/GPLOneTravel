//
//  TrainViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "TrainViewController.h"
#import "downLoad.h"
#import "NSString+URLEncoding.h"
#import "TrainsTableViewCell.h"
#import "TrainModel.h"
@interface TrainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableview;
    NSMutableArray *_trainArray;
}
@end

@implementation TrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(fanhui)];
    self.title = @"列表";
    self.navigationController.navigationBar.barTintColor
    = WColorRGB(131, 150, 175);
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *ima = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Size.width, 100)];
    ima.image = [UIImage imageNamed:@"train.png"];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Size.width, Screen_Size.height) style:UITableViewStylePlain];
    _tableview.delegate =self;
    _tableview.dataSource = self;
    _tableview.tableHeaderView = ima;
    _tableview.rowHeight = 150;
    UINib *nib = [UINib nibWithNibName:@"TrainsTableViewCell" bundle:nil];
    [_tableview registerNib:nib forCellReuseIdentifier:@"TrainsTableViewCell"];
    [self.view addSubview:_tableview];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getData];
}
- (void)clickScreen
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self getData];
                });
    
}
- (void)getData
{
    
    _trainArray = [[NSMutableArray alloc]init];
    [downLoad downLoadWithType:downLoadTypeGET downLoadWithPath:[self.path URLEncodedString] parameter:nil success:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSString *restring = [NSString stringWithFormat:@"%@",dict[@"result"]];
        if ([restring isEqualToString:@"<null>"]) {
            UIView *failview =[[UIView alloc]initWithFrame:self.view.bounds];
            failview.center = self.view.center;
            UIImageView *im = [[UIImageView alloc]initWithFrame:self.view.bounds];
            im.userInteractionEnabled = YES;
            UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
            bu.frame  = self.view.bounds;
            [bu addTarget:self action:@selector(clickScreen) forControlEvents:UIControlEventTouchUpInside];
            [im addSubview:bu];

            im.image = [UIImage imageNamed:@"fail.jpg"];
            [failview addSubview:im];
            [self.view addSubview:failview];

            
        }else{
        NSArray *array = dict[@"result"][@"list"];
        NSArray *arr = [TrainModel arrayOfModelsFromDictionaries:array];
        for (TrainModel *train in arr) {
            [_trainArray addObject:train];
        }
            
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_tableview reloadData];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _trainArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrainsTableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TrainModel *mo = _trainArray[indexPath.row];
    cell.trainModel = mo;
    return cell;
}

- (void)fanhui
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrainModel *mo = _trainArray[indexPath.row];
    NSString *path = mo.m_train_url;

    UIAlertController *al = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要跳转到详情页?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self gotodetail:path];
    }];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotodetail:path];
    }];
    
    self.alerArray = @[ac,act];
    for (UIAlertAction *alv in self.alerArray) {
        [al addAction:alv];
    }
    [self presentViewController:al animated:YES completion:nil];
    
}
- (void)gotodetail:(NSString *)path
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:path]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
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
