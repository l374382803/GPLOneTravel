//
//  locationMap.m
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "locationMap.h"

@implementation locationMap
{
        CLLocationManager *_locationManage;
        CLGeocoder *_currentCity;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getCityName];
    }
    return self;
}

- (void)getCityName
{
    if([CLLocationManager locationServicesEnabled]==YES){
        _locationManage = [[CLLocationManager alloc]init];
        _currentCity = [[CLGeocoder alloc]init];
        
        //授权
        [_locationManage requestWhenInUseAuthorization];
        _locationManage.delegate = self;
        _locationManage.distanceFilter = 1000.0f;
        //定位精度
        _locationManage.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManage startUpdatingLocation];
        
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //for (CLLocation *location in locations) {
      //  NSLog(@"%@",location);
   // }
    CLLocation *lastPostion = locations.lastObject;
    //地球坐标转化成火星坐标
    CLLocation *mars = [lastPostion locationMarsFromEarth];
    //得到经纬度
    CLLocationCoordinate2D coordinate = mars.coordinate;
    NSLog(@"(%g---%g)",coordinate.latitude,coordinate.longitude);
   
    [self gerCityname:lastPostion];
    
    
}
- (void)gerCityname:(CLLocation *)lastPostion
{
    [_currentCity reverseGeocodeLocation:lastPostion completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark = [placemarks objectAtIndex:0];
        NSString *currentCityStr= [placeMark locality];
        //NSLog(@"---%@",currentCityStr);
        self.cityDingWeiName = currentCityStr;
        [self block];
    }];
   
}
- (void)block
{
    [self.delegate changeName];
}
//- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if (status == kCLAuthorizationStatusDenied) {
//        NSLog(@"jujue");
//    }else{
//        NSLog(@"123");
//    }
//}
- (void)viewWillDisappear:(BOOL)animated
{
    [_locationManage stopUpdatingLocation];
}


@end
