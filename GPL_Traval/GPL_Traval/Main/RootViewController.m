//
//  RootViewController.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "RDVTabBarItem.h"
#import "HomeViewController.h"
#import "TravelDateViewController.h"
#import "StarViewController.h"
#import "SearchViewController.h"
#import "MineViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /**
     主页
     */
    HomeViewController *homePage =
        [[HomeViewController alloc] initWithNibName:@"HomeViewController"
                                             bundle:nil];
    SCNavigationController *homeNvc =
        [[SCNavigationController alloc] initWithRootViewController:homePage];

    /**
     游记
     */
    TravelDateViewController *travelPage = [[TravelDateViewController alloc]
        initWithNibName:@"TravelDateViewController"
                 bundle:nil];
    SCNavigationController *travelNvc =
        [[SCNavigationController alloc] initWithRootViewController:travelPage];
    /**
     运势
     */
    StarViewController *starPage =
        [[StarViewController alloc] initWithNibName:@"StarViewController"
                                             bundle:nil];
    SCNavigationController *starNvc =
        [[SCNavigationController alloc] initWithRootViewController:starPage];
    /**
     查询
     */
    SearchViewController *searchPage =
        [[SearchViewController alloc] initWithNibName:@"SearchViewController"
                                               bundle:nil];
    SCNavigationController *searchNvc =
        [[SCNavigationController alloc] initWithRootViewController:searchPage];
    /**
     我的
     */
    MineViewController *minePage =
        [[MineViewController alloc] initWithNibName:@"MineViewController"
                                             bundle:nil];
    SCNavigationController *mineNvc =
        [[SCNavigationController alloc] initWithRootViewController:minePage];
    /**
     *  <#Description#>
     */
    self.viewControllers = @[ homeNvc, travelNvc, starNvc, searchNvc, mineNvc ];
    
    [self customizeTabBarForController:self];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    tabBarController.tabBar.backgroundView.backgroundColor = WColorRGB(34, 8, 7);
    NSInteger index = 0;
    NSArray *title = @[@"主页",@"游记",@"星运",@"查询",@"我的"];
    NSArray *itemImages = @[@"shouye",@"youji",@"star",@"price",@"mine"];
    
    NSDictionary *unselectedTitleAttributes = nil;
    NSDictionary *selectedTitleAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        unselectedTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName: WColorRGB(147, 145, 145)};
        
        selectedTitleAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName: WColorRGB(199, 57, 32)};
    }
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //设置title
        item.title = title[index];
        NSString *normalImageStr = [NSString stringWithFormat:@"%@_normal.png",itemImages[index]];
        NSString *selectedImageStr = [NSString stringWithFormat:@"%@_selected.png",itemImages[index]];
        UIImage *normalImage = [UIImage imageNamed:normalImageStr];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageStr];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        item.unselectedTitleAttributes = unselectedTitleAttributes;
        item.selectedTitleAttributes = selectedTitleAttributes;
        
        index++;
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
