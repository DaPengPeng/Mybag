//
//  ViewController.m
//  PhotoView
//
//  Created by bever on 16/4/14.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "ViewController.h"
#import "PhotoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PhotoView *photoView = [[PhotoView alloc] init];
    photoView.dataList = @[@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://img313.ph.126.net/ECoJRg_Hv0UgfvzrR05xUw==/3678314995655388709.jpg",@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://imgsrc.baidu.com/baike/pic/item/b2de9c82d158ccbf6fe124131bd8bc3eb13541bd.jpg",@"http://img313.ph.126.net/ECoJRg_Hv0UgfvzrR05xUw==/3678314995655388709.jpg",@"http://img313.ph.126.net/ECoJRg_Hv0UgfvzrR05xUw==/3678314995655388709.jpg",@"http://posters.imdb.cn/ren-pp/0000093/fuVyjgLN1_1189973659.jpg"];
    
    [self.view addSubview:photoView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
