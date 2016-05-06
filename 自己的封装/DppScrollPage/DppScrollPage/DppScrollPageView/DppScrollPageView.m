//
//  DppScrollPageView.m
//  DppScrollPage
//
//  Created by bever on 16/4/16.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "DppScrollPageView.h"
#import "TouchImageView.h"

@implementation DppScrollPageView {

    UIScrollView *_scrollView;
    
    UIPageControl *_pageControl;
    
    BOOL _isHiden;
    
    UIImageView *_imageView;
}

- (void)setDataList:(NSArray *)dataList {

    _dataList = dataList;
    
    self.backgroundColor = [UIColor grayColor];
    
    //创建scrollView
    [self createScrollView];
    
    //创建分页控制器
    [self createPageControl];
}

//创建scrollView
- (void)createScrollView {

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:_scrollView];
    
    //计算每一个页面上item的数量
    NSInteger widthCount = (self.bounds.size.width-_minSpace)/(_itemSize.width+_minSpace);
    NSInteger heightCount = (self.bounds.size.height-_minSpace)/(_itemSize.height+_minSpace);
    NSInteger onePageItemCount = widthCount * heightCount;
    BOOL hasMod = _dataList.count%onePageItemCount;
    NSInteger pageCount = _dataList.count/onePageItemCount+1*hasMod;
    
    //_scrollView的设置
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width*pageCount, self.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    CGFloat itemWidth = _itemSize.width;
    CGFloat itemHeight = _itemSize.height;
    
    //在scroolView上添加imageView
    for (int i = 0; i < _dataList.count; i++) {
        
        TouchImageView *imageView = [[TouchImageView alloc] initWithFrame:CGRectMake((i/onePageItemCount)*self.bounds.size.width+_minSpace+((i%onePageItemCount)%widthCount)*(itemWidth+_minSpace), _minSpace+((i%onePageItemCount)/widthCount)*(itemHeight+_minSpace), itemWidth, itemHeight)];
        NSString *pngString = _dataList[i][@"png"];
        
        imageView.image = [UIImage imageNamed:pngString];
        imageView.userInteractionEnabled = YES;
        imageView.multipleTouchEnabled = YES;
        imageView.tag = 100+i;

        [_scrollView addSubview:imageView];
    }
}

//创建分页控制器
- (void)createPageControl {
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height-20, width, 20)];
    
    //分也控制器的设置
    _pageControl.numberOfPages = _scrollView.contentSize.width/width;
    _pageControl.enabled = NO;
    _pageControl.tintColor = [UIColor greenColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addSubview:_pageControl];
}

//scrollView与pageControl的绑定
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger currentPage = scrollView.contentOffset.x/self.bounds.size.width;
    _pageControl.currentPage = currentPage;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch= [touches anyObject];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(touch.view.center.x-0.75f*_itemSize.width, touch.view.center.y-2*_itemSize.height, 1.5*_itemSize.width, 1.5*_itemSize.height)];
    NSLog(@"_imageView.Frame%@",NSStringFromCGRect(_imageView.frame));
    NSString *gifString = _dataList[touch.view.tag-100][@"gif"];
    _imageView.image = [UIImage imageNamed:gifString];
    [_scrollView addSubview:_imageView];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_imageView removeFromSuperview];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [_imageView removeFromSuperview];
    
}
@end
