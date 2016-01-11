//
//  downLoad.m
//  AF_NextWorking
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "downLoad.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
@implementation downLoad

+ (void)downLoadWithType:(downLoadType)type downLoadWithPath:(NSString *)path parameter:(NSDictionary *)parameter success:(void (^)(NSData *))success fail:(void (^)(NSError *))fail
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (type == downLoadTypePOST) {
        
        [manage POST:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            fail(error);
        }];

    }else if(type == downLoadTypeGET)
    {
                [manage GET:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(responseObject);
        
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    fail(error);
                }];
    }

}

+ (void)upLoadImageWithPath:(NSString *)path parameter:(NSDictionary *)parameter imagepathForResource:(NSString *)imagename imageType:(NSString *)type keyName:(NSString *)keyname newImageName:(NSString *)newName  mimeType:(NSString *)mimeType success:(void(^)(NSData *data))success fail:(void(^)(NSError *error))fail
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        [manage POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           
            NSString *str = [[NSBundle mainBundle]pathForResource:imagename ofType:type];
            NSString *string = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFileURL:[NSURL URLWithString:string] name:keyname fileName:newName mimeType:mimeType error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            fail(error);
        }];

    
}
+(void)downlaodImageWithPat:(NSString *)path imageview:(UIImageView *)imageview placeholderImage:(UIImage*)image
{
    NSString *str = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    [imageview setImageWithURL:url placeholderImage:image];
}
+(void)loginWithPath:(NSString *)path parameter:(NSDictionary *)parameter success:(void(^)(NSData *data))success fail:(void(^)(NSError *error))fail
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage POST:path parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail(error);
    }];
}

    
@end
