//
//  MineViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MineViewController.h"
#import "StrechDemoViewController.h"
#import "HeaderStretchingTableViewController.h"
#import "GuanYuViewController.h"
#import <SDImageCache.h>
//#import <MBProgressHUD.h>
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UITableView *tableview;
    UIImagePickerController *_picker;
    UIImage *_image;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.sc_navigationItem.title = @"我的";
    
    self.avatarView1 = [[MCAvatarView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.avatarView1.delegate = self;
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *userimage = [UIImage imageWithContentsOfFile:path];
    if (userimage == nil) {
        self.avatarView1.image = [UIImage imageNamed:@"user_defaultavatar"];
    }else{
        self.avatarView1.image = userimage;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Size.width, 150)];
    //view.backgroundColor = [UIColor colorWithRed:0.811 green:1.000 blue:0.113 alpha:1.000];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back3"]];
    self.avatarView1.center = view.center;
    [view addSubview:self.avatarView1];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Screen_Size.width, Screen_Size.height) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableHeaderView = view;
    tableview.userInteractionEnabled = YES;
    [self.view addSubview:tableview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"share_icon"];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"打赏评价";
            break;
        case 1:
            cell.textLabel.text = @"清理缓存";
            break;
        case 2:
            cell.textLabel.text = @"关于我们";
            break;
    }
    
    return cell;
}
- (void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:tableview animated:YES];
}
-(void)avatarViewOnTouchAction:(MCAvatarView *)avatarView {
    UIAlertController *al = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];    
    UIAlertAction * photoaction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showHUDAddedTo:tableview animated:YES];
        [self photo];
    }];
    UIAlertAction * camaction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self camera];
    }];
    UIAlertAction * cancleaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
    [al addAction:photoaction];
    [al addAction:camaction];
    [al addAction:cancleaction];
    [self presentViewController:al animated:YES completion:nil];
}
- (void)photo
{
    _picker = [[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
       // NSLog(@"支持相册");
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _picker.allowsEditing = YES;
        _picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:_picker animated:YES completion:nil];
    }
    
    
}
- (void)camera
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"支持相机");
        _picker = [[UIImagePickerController alloc]init];
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_picker animated:YES completion:nil];
    }

}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info;
{
    NSLog(@"123456");
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    //将图片保存到本地
    [self saveImage:image withName:@"currentImage.png"];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:path];
    _image = saveImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self upDateImage:saveImage];
}
- (void)saveImage:(UIImage *)im withName:(NSString *)str
{
    NSData *data = UIImageJPEGRepresentation(im, 0.5);
    //获取沙盒目录
    NSString *string = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:str];
    [data writeToFile:string atomically:NO];
    //UIImage *ime = [UIImage imageWithData:<#(nonnull NSData *)#>]
}
- (void)upDateImage:(UIImage *)im
{
    self.avatarView1.image = im;
    [tableview reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
    GuanYuViewController *guanyu = [[GuanYuViewController alloc]initWithNibName:@"GuanYuViewController" bundle:nil];
    
    [self.navigationController pushViewController:guanyu animated:YES];
    }else if (indexPath.section == 1){
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
        float clear = [self folderSizeAtPath:path];
        
        UIAlertController *alcon = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小为%2.fM.确定缓存吗?",clear] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
                [self clearCache:path];
                [self alter];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alcon addAction:action1];
        [alcon addAction:action];
        [self presentViewController:alcon animated:YES completion:nil];
        
    }else{
        NSString *path = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",1060065831];
        //NSLog(@"103123131324165465fksjfhnkjshnfkskasfsafa4");
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:path]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
        }else{
            UIAlertController *alcon = [UIAlertController alertControllerWithTitle:@"提示" message:@"出现了点小问题" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES     completion:nil];
            }];
            [alcon addAction:action];
            [self presentViewController:alcon animated:YES completion:nil];
        }
        
    }
    
}

-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            if (![fileName isEqualToString:@"Documents"]) {
                
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }else{
                NSLog(@"避开了Document文件夹--%@",path);
            }
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
- (void)alter
{
    UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经为你清理了缓存" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alc animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//com.1539qianfeng.net


//1060065831

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
