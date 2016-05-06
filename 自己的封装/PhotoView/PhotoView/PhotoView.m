//
//  PhotoView.m
//  PhotoView
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "PhotoView.h"
#import "PhotoImageView.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "PhotoViewPresentController.h"

#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

@implementation PhotoView

//复写set方法
- (void)setDataList:(NSArray *)dataList {

    _dataList = dataList;
    
    //创建imageView
    [self createImageViews];
}


- (void)createImageViews {

    //photoView高度的设定
    CGFloat minspacing = 15;
    BOOL hasY = _dataList.count%3;
    self.frame = CGRectMake(0, 200, kScreenW, ((kScreenW-minspacing*2-20))/3*((_dataList.count/3)+1*hasY)+(((_dataList.count/3)+1*hasY)-1)*15+20);
    _subViewsDic = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < _dataList.count; i++) {
    
        PhotoImageView *imageView = [[PhotoImageView alloc] initWithFrame:CGRectMake(10+(i%3)*((kScreenW-minspacing*2-20)/3+15), 10+(i/3)*((kScreenW-minspacing*2-20)/3+15), (kScreenW-minspacing*2-20)/3, (kScreenW-minspacing*2-20)/3)];
        imageView.index = i;
        NSString *indexString = [NSString stringWithFormat:@"%d",i];
        [_subViewsDic setObject:imageView forKey:indexString];
        imageView.oldFrame = imageView.frame;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:_dataList[i]]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {

    PhotoViewPresentController *presentController = [[PhotoViewPresentController alloc] init];
    PhotoImageView *imageView = (PhotoImageView *)tap.view;
    presentController.imageView = imageView;
    presentController.dataList = _dataList;
    presentController.photoView = self;
    [[self viewController] presentViewController:presentController animated:NO completion:^{
        
        
    }];
}



@end
