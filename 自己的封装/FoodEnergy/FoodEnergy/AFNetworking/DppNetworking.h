//
//  DppNetworking.h
//  DppWB
//
//  Created by bever on 16/4/9.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^resulteBlock)(id resulte);

@interface DppNetworking : NSObject

+ (void)GET:(NSString *)url parmeters:(NSDictionary *)parmeters resulteBlock:(resulteBlock)block;

@end
