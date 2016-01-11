//
//  TravelDateViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "TravelDateViewController.h"
#import "NotesViewController.h"
#import "DateTableViewCell.h"
#import "NotesModel.h"
#import "MessageSQL.h"
#import "LookAndChangeViewController.h"
@interface TravelDateViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_backImageView;
    UITableView *_tableview;
    NSMutableArray *_dataSource;
}
@end

@implementation TravelDateViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self getData];
    [super viewWillAppear:animated];
    _backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"back%d",arc4random()%2+1]];
    [self addImageView];
}
- (void)addImageView
{
    UIImageView *imageView= [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.alpha = 0.8;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"title%d",arc4random()%1+1]];
    UILabel *la = [[UILabel alloc]init];
    la.frame = CGRectMake(0, 0, 200, 350);
    la.center = self.view.center;
    la.textColor = WColorRGB(248, 147, 29);
    la.textAlignment = NSTextAlignmentCenter;
    la.font = [UIFont fontWithName:@"Bradley Hand" size:25];
    la.numberOfLines = 0;
    la.text = @"Let the life become good writing your notes, living with bright life bit by bit. Love life love to travel.";
    [imageView addSubview:la];
    [self.view addSubview:imageView];
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sc_navigationItem.title = @"游记";
    _backImageView = [[UIImageView alloc]init];
    _backImageView.frame = CGRectMake(0, 64, Screen_Size.width, Screen_Size.height-109);
    _backImageView.userInteractionEnabled = YES;
    _backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"back%d",arc4random()%2+1]];
    [self.view addSubview:_backImageView];
    [self tableview];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    bu.frame = CGRectMake(5, 20, 60, 30);
    [bu addTarget:self action:@selector(addNotes) forControlEvents:UIControlEventTouchUpInside];

    self.sc_navigationItem.rightBarButtonItem = [[SCBarButtonItem alloc]initWithCustomView:bu];
    _dataSource = [[NSMutableArray alloc]init];
    
    
    
}
- (void)addNotes
{
    NotesViewController *note = [[NotesViewController alloc]init];
    [self.navigationController pushViewController:note animated:YES];
}
- (void)tableview
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Size.width, Screen_Size.height-109) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.alpha = 0.5;
    _tableview.rowHeight = 75;
    [_tableview setSeparatorColor:WColorRGB(150, 11, 120)];
    UINib *nib = [UINib nibWithNibName:@"DateTableViewCell" bundle:nil];
    [_tableview registerNib:nib forCellReuseIdentifier:@"DateTableViewCell"];
    [_backImageView addSubview:_tableview];
}

- (void)getData
{
    [_dataSource removeAllObjects];
    MessageSQL *sql = [MessageSQL shareInstance];
    [_dataSource addObjectsFromArray:[sql getAllData]];
    [_tableview reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateTableViewCell" forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    NotesModel *mo = _dataSource[indexPath.row];
    cell.model = mo;

    return cell;
}
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    // 重写编辑按钮的点击事件，因此先要调用父类方法
//    [super setEditing:editing animated:animated];
//    // 打开表格的编辑模式
//    [_tableview setEditing:editing animated:YES];
//}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotesModel *mo = _dataSource[indexPath.row];
    NSString *textString = mo.dateString;
    LookAndChangeViewController *lookchan = [[LookAndChangeViewController alloc]init];
    lookchan.text = textString;
    [self.navigationController pushViewController:lookchan animated:YES];
}
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        NotesModel *mo = _dataSource[indexPath.row];
        NSString *str = mo.dateString;
        MessageSQL *sql = [MessageSQL shareInstance];
        [sql delegateData:str];
        // 删除选中的那一行（1；先从数据源里删除对应的元素）
        [_dataSource removeObjectAtIndex:indexPath.row];
        // 提交并刷新列表（2；从列表里删除对应行）
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self getData];
        /*
         UITableViewRowAnimationRight,
         UITableViewRowAnimationLeft,
         UITableViewRowAnimationTop,
         UITableViewRowAnimationBottom,
         UITableViewRowAnimationNone,
         UITableViewRowAnimationMiddle,
         UITableViewRowAnimationAutomatic
         */
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
