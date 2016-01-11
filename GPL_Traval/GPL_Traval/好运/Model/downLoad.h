//
//  downLoad.h
//  AF_NextWorking
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, downLoadType) {
    downLoadTypePOST,
    downLoadTypeGET
};

@interface downLoad : NSObject
//下载数据 
+ (void)downLoadWithType:(downLoadType)type downLoadWithPath:(NSString *)path parameter:(NSDictionary *)parameter success:(void(^)(NSData *data))success fail:(void(^)(NSError *error))fail;
//上传图片
+ (void)upLoadImageWithPath:(NSString *)path parameter:(NSDictionary *)parameter imagepathForResource:(NSString *)imagename imageType:(NSString *)type keyName:(NSString *)keyname newImageName:(NSString *)newName  mimeType:(NSString *)mimeType success:(void(^)(NSData *data))success fail:(void(^)(NSError *error))fail;
//下载头像
+(void)downlaodImageWithPat:(NSString *)path imageview:(UIImageView *)imageview placeholderImage:(UIImage*)image;

//登录
+(void)loginWithPath:(NSString *)path parameter:(NSDictionary *)parameter success:(void(^)(NSData *data))success fail:(void(^)(NSError *error))fail;

@end
