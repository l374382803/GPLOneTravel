//
//  locationMap.h
//  GPL_Traval
//
//  Created by qianfeng on 15/11/7.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+Sino.h"
#import <MapKit/MapKit.h>

@protocol MapDelegateCityName <NSObject>

- (void)changeName;

@end

@interface locationMap : NSObject<CLLocationManagerDelegate>
@property (nonatomic)id<MapDelegateCityName>delegate;
@property (nonatomic,strong)NSString *cityDingWeiName;



@end
