//
//  HomeViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HomeViewController.h"
#import "CityListViewController.h"
#import "detailViewController.h"
//#import "locationMap.h"
#import "scrollView.h"
#import "HomeDetailTableViewCell.h"
#import "TwoCodeViewController.h"
#import "HomeModel.h"
#import "DeHomeViewController.h"
#import "RDVTabBarController.h"
@interface HomeViewController () <CityListViewDelegate,
    UITableViewDelegate,
    UITableViewDataSource> {
    /**
   *  leftButton
   */
    SCBarButtonItem* cityList;

    NSMutableString* nameCity;
    /**
   *  常用城市
   */
    NSMutableArray* historyCity;
    //locationMap* location;
    /**
   *  tableview
   */
    UITableView* _tableview;
    /**
   *  default存储常用城市
   */
    NSUserDefaults* defaults;

    float y;

    scrollView* scroll;
    NSArray* _detailArray;
    NSInteger page;
    NSMutableArray* homeDetailMessageArray;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sc_navigationItem.title = @"主页";
    _detailArray = [[NSArray alloc] init];

    nameCity = [[NSMutableString alloc] init];
    nameCity = [NSMutableString stringWithFormat:@"北京"];
    if (historyCity == nil) {
        historyCity = [[NSMutableArray alloc] init];
    }
    defaults = [NSUserDefaults standardUserDefaults];
    homeDetailMessageArray = [[NSMutableArray alloc] init];
    [self creatLeftButton:nameCity];
    [self rightBarButtonItem];

    //创建scrollview
    [self creatScrollView];
    [self creatTableView];
    [self getData:1];
    SCBarButtonItem* twoCode = [[SCBarButtonItem alloc]
        initWithTitle:@"扫一扫"
                style:SCBarButtonItemStylePlain
              handler:^(id sender) {
                  TwoCodeViewController* two = [[TwoCodeViewController alloc] init];
                  // self.hidesBottomBarWhenPushed = YES;

                  __weak typeof(self) weakSelf = self;
                  [weakSelf.navigationController pushViewController:two
                                                           animated:YES];

              }];

    self.sc_navigationItem.rightBarButtonItem = twoCode;
}
- (void)rightNavtionButton
{
}
- (void)creatScrollView
{
    scroll = [[scrollView alloc]
        initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,
                          150)];
    __weak typeof(self) weakSelf = self;
    scroll.checkNew = ^(NSInteger index) {
        [weakSelf detailView:(index)];
    };
    [self.view addSubview:scroll];
}
/**
 *  创建letftBUtton
 *
 *  @param name button的名字
 */
- (void)creatLeftButton:(NSString*)name
{
    cityList = [[SCBarButtonItem alloc]
        initWithTitle:name
                style:SCBarButtonItemStylePlain
              handler:^(id sender) {
                  __weak typeof(self) weakSelf = self;
                  CityListViewController* city =
                      [[CityListViewController alloc] init];

                  city.delegate = self;

                  //热门城市列表
                  city.arrayHotCity = [NSMutableArray
                      arrayWithObjects:@"北京", @"上海", @"武汉", @"郑州",
                      @"广州", @"天津", @"厦门", @"重庆",
                      @"福州", @"泉州", @"济南", @"深圳",
                      @"长沙", @"无锡", @"石家庄",
                      @"青岛", @"秦皇岛", @"台北",
                      @"昆明", @"苏州", nil];
                  //历史选择城市列表
                  //NSLog(@"%@", [defaults objectForKey:@"city"]);
                  city.arrayHistoricalCity = [defaults objectForKey:@"city"];
                  //定位城市列表
                  //              city.arrayLocatingCity = [NSMutableArray
                  //                  arrayWithObjects:location.cityDingWeiName, nil];
                  [weakSelf presentViewController:city animated:YES completion:nil];
              }];

    self.sc_navigationItem.leftBarButtonItem = cityList;
}
/**
 *  点击scrollview进入详情页
 *
 *  @param index 第几张图片
 */
- (void)detailView:(NSInteger)index
{
    NSString* path =
        [[NSBundle mainBundle] pathForResource:@"Detail"
                                        ofType:@"plist"];
    _detailArray = [NSArray arrayWithContentsOfFile:path];
    detailViewController* detail =
        [[detailViewController alloc] initWithNibName:@"detailViewController"
                                               bundle:nil];
    detail.iconStr = _detailArray[index][@"iconTitle"];
    detail.detailText = _detailArray[index][@"textDetail"];
    detail.titleText = _detailArray[index][@"title"];
    detail.array = [NSArray arrayWithArray:_detailArray[index][@"hotVisitTitle"]];
    __weak typeof(self) weakSelf = self;
    [weakSelf.navigationController pushViewController:detail animated:YES];
}
/**
 *  城市列表回调协议
 *
 *  @param cityName 返回都市的名字
 */
- (void)didClickedWithCityName:(NSString*)cityName
{
    [self creatLeftButton:cityName];
    [historyCity addObject:cityName];
    NSMutableArray* arr = historyCity;

    [defaults setObject:arr forKey:@"city"];
    [defaults synchronize];
}
/**
 *  创建tableview
 */
- (void)creatTableView
{
    //创建scrollview

    _tableview =
        [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Size.width,
                                               Screen_Size.height - 109 + 49)
                                     style:UITableViewStylePlain];

    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.rowHeight = 275;
    _tableview.tableHeaderView = scroll;
    _tableview.tableFooterView = nil;
    _tableview.mj_header =
        [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                         refreshingAction:@selector(refreshData)];
    [_tableview.mj_header beginRefreshing];
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downLoadMore)];
    _tableview.mj_footer.ignoredScrollViewContentInsetBottom = 30;

    [self.view addSubview:_tableview];
}
- (void)downLoadMore
{
    ++page;
    [self getData:page];
}
- (void)refreshData
{

    [self getData:1];
}
- (void)getData:(NSInteger)pa
{
    NSString* httpUrl =
        @"http://apis.baidu.com/qunartravel/travellist/travellist";
    NSString* httpArg = [NSString stringWithFormat:@"page=%ld", pa];
    [self request:httpUrl withHttpArg:httpArg];
    [_tableview.mj_header endRefreshing];
    [_tableview.mj_footer endRefreshing];
}
- (void)request:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString* urlStr =
        [[NSString alloc] initWithFormat:@"%@?%@", httpUrl, HttpArg];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]
            initWithURL:url
            cachePolicy:NSURLRequestUseProtocolCachePolicy
        timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request addValue:apiKey forHTTPHeaderField:@"apikey"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response,
                                                 NSData* data, NSError* error) {
                               if (error) {

                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                               }
                               else {
                                   NSDictionary* dic =
                                       [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:nil];

                                   NSArray* array = dic[@"data"][@"books"];
                                   for (NSDictionary* home in array) {
                                       NSMutableDictionary* homedictionary = [[NSMutableDictionary alloc] initWithDictionary:home];
                                       NSString* str = [NSString stringWithFormat:@"%@", homedictionary[@"headImage"]];
                                       if ([str isEqualToString:@"<null>"]) {
                                           NSLog(@"486746974646545s6d4f65sd4f65s464af6545a6f465a4f65a4f65a4f");
                                           [homedictionary setObject:@"http://img1.qunarzz.com/travel/d3/1511/96/3a17a58f2fbf1ef7.jpg_r_650x487x95_27b4658f.jpg" forKey:@"headImage"];
                                       }
                                       // NSLog(@"******%@",homedictionary[@"headImage"]);
                                       HomeModel* model = [[HomeModel alloc] initWithDictionary:homedictionary error:nil];

                                       [homeDetailMessageArray addObject:model];
                                   }

                                   /*
                               NSError *error = nil;
                               NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                               modelArray = [HomeModel arrayOfModelsFromDictionaries:array error:&error];
                               
                               for (HomeModel *model in modelArray) {
                                   [homeDetailMessageArray addObject:model];
                                   
                               }*/

                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [_tableview reloadData];
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   });
                               }

                           }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return homeDetailMessageArray.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    HomeDetailTableViewCell* cell =
        [tableView dequeueReusableCellWithIdentifier:@"HomeViewController"];

    if (!cell) {
        cell = [[HomeDetailTableViewCell alloc]
              initWithStyle:UITableViewCellStyleSubtitle
            reuseIdentifier:@"HomeViewController"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    HomeModel* mo = homeDetailMessageArray[indexPath.row];
    cell.hoModel = mo;
    return cell;
}
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    DeHomeViewController* dehome = [[DeHomeViewController alloc] init];
    HomeModel* mode = homeDetailMessageArray[indexPath.row];
    NSString* url = mode.headImage;
    NSString* text = mode.text;
    dehome.iconUrl = url;
    dehome.messageText = text;
    [self.navigationController pushViewController:dehome animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    float q = scrollView.contentOffsetY;
    if (q > 0) {
        if (y < q) {
            [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        }
        else if (y > q + 10) {
            [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
        }
    }
    y = scrollView.contentOffsetY;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
