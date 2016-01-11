//
//  detailViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "detailViewController.h"
#import "RDVTabBarController.h"
#import "DetailTableViewCell.h"
#import "detailFrame.h"

@interface detailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *_headerView;
    UIView *_backView;
    NSMutableArray *_titleArray;
    NSMutableArray *_dataArray;
    
}
@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    __weak typeof (self) weakSelf = self;
    self.sc_navigationItem.title = _titleText;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    SCBarButtonItem *fanhui = [[SCBarButtonItem alloc]initWithTitle:@"返回" style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.sc_navigationItem.leftBarButtonItem = fanhui;
    [self headerView];
    [self getData];
    [self creatTableView];
    
}
- (void)getData
{
    
    _dataArray = [[NSMutableArray alloc]init];
    _titleArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in _array) {
        detailCellModel *deModel = [[detailCellModel alloc]init];
        deModel.iconStr = dic[@"iconPath"];
        deModel.textStr = dic[@"text"];
        detailFrame *deFrame = [[detailFrame alloc]init];
        deFrame.detailcellmodel = deModel;
        [_dataArray addObject:deFrame];
        [_titleArray addObject:dic[@"listTit"]];
    }
    NSLog(@"%@",_dataArray);
    
}
- (void)headerView
{
    _backView = [[UIView alloc]init];
   
    _headerView = [[UIImageView alloc]init];
    _headerView.frame = CGRectMake(0, 1, Screen_Size.width, 230);
    [_headerView setImageWithURL:[NSURL URLWithString:_iconStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    CGSize textSize = [self getSizeWithString:_detailText];
    UILabel *textLable = [[UILabel alloc]init];
    textLable.numberOfLines = 0;
    textLable.lineBreakMode = NSLineBreakByCharWrapping;
    textLable.font = kName_font;

    textLable.text = _detailText;
    textLable.frame = CGRectMake(0, 233, textSize.width, textSize.height);
    textLable.backgroundColor = [UIColor clearColor];
    _backView.frame = CGRectMake(0, 64, Screen_Size.width, CGRectGetMaxY(textLable.frame)+5);
    [_backView addSubview:textLable];
    [_backView addSubview:_headerView];
    //[self.view addSubview:_backView];
    
}
- (CGSize)getSizeWithString:(NSString *)str
{
    CGSize maxSize = CGSizeMake(Screen_Size.width-4, CGFLOAT_MAX);
    CGSize StrSize = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kName_font} context:nil].size;
    return StrSize;
}
- (void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Size.width, Screen_Size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _backView;
    
    [self.view addSubview:_tableView];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *tit = _titleArray[section];
    
    return tit;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *tit = _titleArray[section];
    UILabel *la = [[UILabel alloc]init];
    la.text = tit;
    la.textColor = [UIColor colorWithRed:0.843 green:0.505 blue:0.099 alpha:1.000];
    la.font = [UIFont boldSystemFontOfSize:18];
    return la;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DetailTableViewCell"];
    }
    detailFrame *frame = _dataArray[indexPath.section];
    cell.detaFram = frame;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailFrame *frame = _dataArray[indexPath.section];
    
    return frame.cellHeight;
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
