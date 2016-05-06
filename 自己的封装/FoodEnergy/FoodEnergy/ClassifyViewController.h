//
//  ClassifyViewController.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,retain) NSMutableArray *dataList;

@property (nonatomic,assign) BOOL isNoPush;

@end
