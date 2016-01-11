//
//  StrechDemoViewController.m
//  TableViewHeaderStretching
//
//  Created by wangchangfei on 15/9/23.
//  Copyright © 2015年 wangchangfei. All rights reserved.
//

#import "StrechDemoViewController.h"

@interface StrechDemoViewController ()
{
    UIButton *leftBtn;
    UIButton *rightBtn;
}
@end

@implementation StrechDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stretchingImageHeight = 200;
    self.stretchingImageName = @"image1.jpg";
    UIView *vi = [[UIView alloc]init];
    vi.backgroundColor = [UIColor greenColor];
    self.tableView.backgroundView = vi;
    self.tableView.tableFooterView = nil;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    return @" ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSArray *arr = @[@"清理缓存",@"关于我们",@"我的笔记"];
    cell.textLabel.text = arr[indexPath.section];
    
    return cell;
}


@end
