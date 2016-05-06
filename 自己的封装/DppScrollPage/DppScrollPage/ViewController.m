//
//  ViewController.m
//  DppScrollPage
//
//  Created by bever on 16/4/16.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "ViewController.h"
#import "DppScrollPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DppScrollPageView *scrollPageView = [[DppScrollPageView alloc] initWithFrame:CGRectMake(0, 100, 414, 100)];
    
    scrollPageView.minSpace = 10;
    scrollPageView.itemSize = CGSizeMake(30, 30);
    
    //数据的加载
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
//    for (NSDictionary *dic in array) {
//        NSString *png = dic[@"png"];
//        [mutableArray addObject:png];
//    }
//    
//    scrollPageView.dataList = mutableArray;
    scrollPageView.dataList = array;
    [self.view addSubview:scrollPageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
