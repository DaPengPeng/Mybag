//
//  DetailViewController.h
//  FoodEnergy
//
//  Created by bever on 16/4/22.
//  Copyright © 2016年 bever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSNumber *foodId;

@end
