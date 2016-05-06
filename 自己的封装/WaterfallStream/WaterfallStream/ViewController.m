//
//  ViewController.m
//  WaterfallStream
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "ViewController.h"
#import "DppFlowLayout.h"
#import "WaterfallCollectionCell.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>{

    UICollectionView *_collectionView;
}

@end

@implementation ViewController
static NSString *const identifer = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建布局类
    DppFlowLayout *layout = [[DppFlowLayout alloc] init];
    
    //创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:@"WaterfallCollectionCell" bundle:nil] forCellWithReuseIdentifier:identifer];

}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterfallCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
  
    return cell;
}

@end
