//
//  DppNetworking.m
//  DppWB
//
//  Created by bever on 16/4/9.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "DppNetworking.h"
#import "AFNetworking.h"

@implementation DppNetworking

+ (void)GET:(NSString *)url parmeters:(NSDictionary *)parmeters resulteBlock:(resulteBlock)block {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parmeters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error is:%@",error);
    }];
}

@end
