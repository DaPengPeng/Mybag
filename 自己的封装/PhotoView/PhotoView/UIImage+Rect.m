//
//  UIImage+Rect.m
//  PhotoView
//
//  Created by bever on 16/4/13.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "UIImage+Rect.h"
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

@implementation UIImage (Rect)

- (CGRect)rect {

    CGFloat scale = kScreenW/self.size.width;
    CGFloat height = self.size.height *scale;
    
    CGFloat y = (kScreenH - height)/2;
    
    return CGRectMake(0, y, kScreenW, height);
}

@end
