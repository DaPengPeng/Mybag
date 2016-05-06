//
//  TouchImageView.m
//  DppScrollPage
//
//  Created by bever on 16/4/16.
//  Copyright © 2016年 贝沃. All rights reserved.
//

#import "TouchImageView.h"

@implementation TouchImageView



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _isHiden = NO;
    
    [self.nextResponder.nextResponder touchesBegan:touches withEvent:event];
    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.nextResponder.nextResponder touchesMoved:touches withEvent:event];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    _isHiden = YES;
    
    [self.nextResponder.nextResponder touchesEnded:touches withEvent:event];
}


/*
 //头视图的返回
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
 UICollectionView *mainViewScrolllView;
 
 
 for (UIView *view in _mainView.subviews) {
 if ([view isKindOfClass:[UICollectionView class]]) {
 mainViewScrolllView = (UICollectionView *)view;
 }
 }
 
 if (section == 1) {
 
 ButtonsView *buttonsView = [[ButtonsView alloc] init];
 buttonsView.buttonBlock = ^(NSInteger index) {
 
 //            mainViewScrolllView.contentOffset = CGPointMake(index*kScreenW, 0)
 ;
 [mainViewScrolllView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
 _itemIndex = index;//数据的记录（加了个中间层，防止循环引用）
 };
 //数据的赋值
 _mainView.block = ^(NSInteger index) {
 
 buttonsView.currentIndex = index;
 };
 buttonsView.currentIndex = _itemIndex;
 buttonsView.frame = CGRectMake(0, 0, kScreenW, 40);
 buttonsView.selectedImage = @"up_home";
 buttonsView.titleArray = @[@"动态",@"照片",@"记录"];//注意这里，图片的传递写在数组的传递之前。
 
 return buttonsView;
 }
 return nil;
 }

 
 //单元格个数的返回
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
 return 1;
 }
 
 //单元格的返回
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 //上部视图的返回
 if (indexPath.section == 0 && indexPath.row == 0) {
 UserInfoFirestCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoFirestCell" owner:nil options:nil] firstObject];
 cell.model = _dataList[0];
 return cell;
 }else {//下部视图的返回
 
 UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-40)];
 _mainView = [[UserInfoMainView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-104)];
 _mainView.contentOffset = _yContentOffset;
 [cell addSubview:_mainView];
 _mainView.tableView.userInteractionEnabled = NO;
 return cell;
 }
 }
 
 
 
 //组数的返回
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
 return 2;
 }
 
 //单元格高度的返回
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (tableView == _mainView.tableView) {
 
 //获取model数据
 SelfDynamicModel *model = _mainView.dataList[indexPath.row];
 
 //contentLabel的高度自适应
 CGRect rect = [model.text boundingRectWithSize:CGSizeMake(kScreenW-30, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
 
 //titleLabel
 CNLabel *titleLabel = [[CNLabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW-16, 0)];
 
 
 if (model.retweetedModel) {
 
 //设置文本
 titleLabel.text = [NSString stringWithFormat:@"%@",model.retweetedModel.text];
 }else {
 
 titleLabel.height = 0;
 }
 
 //计算图片高度
 int imgVH = 0;
 if ([model.pic_urls count] > 0) {
 
 PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 0, _mainView.width, 0)];
 NSMutableArray *urls = [[NSMutableArray alloc] init];
 for (NSDictionary *dic in model.pic_urls) {
 
 NSString *urlString = dic[@"thumbnail_pic"];
 
 [urls addObject:urlString];
 }
 //图片的加载
 photoView.dataList = urls;
 BOOL hasY = urls.count%3;
 photoView.hidden = NO;
 imgVH = ((kScreenW-15*2-20))/3*((urls.count/3)+1*hasY)+(((urls.count/3)+1*hasY)-1)*15+20;
 
 }
 
 //计算转发微博的高度
 int repostVH = 0;
 if (model.retweetedModel) {
 
 //创建微博View对象
 SelfDynamicContentView *dynamicContentView = [[SelfDynamicContentView alloc] initWithFrame:CGRectMake(0, 0, kScreenW-16, 0)];
 
 //调用setWbModel方法 用来获取高度
 dynamicContentView.model = model.retweetedModel;
 repostVH = dynamicContentView.height;
 
 }
 
 return 90 + rect.size.height + titleLabel.height +imgVH + repostVH;
 }
 
 if (indexPath.section == 0) {
 return 160;
 }
 return kScreenH-104;
 }
 
 //头视图高度的返回
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 
 if (section == 1) {
 return 40;
 }
 return 0.00001;
 }
 
 //尾视图高度的返回
 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 
 return 0.00001;
 }
 
 
 //- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 //
 //
 //}
 //
 //-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 //
 //    UITouch *touch = [touches anyObject];
 //    CGPoint point = [touch locationInView:self.view];
 //    CGPoint oldPoint = [touch preciseLocationInView:self.view];
 //    NSLog(@"point%@",NSStringFromCGPoint(point));
 //    NSLog(@"oldPoint%@",NSStringFromCGPoint(oldPoint));
 //    _touchLong = _touchLong + (oldPoint.y - point.y);
 //    NSLog(@"%f",_touchLong);
 //    _tableView.contentOffset = CGPointMake(0, _touchLong);
 //
 //}
 //
 //- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
 //
 //}
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 
 if (scrollView.contentOffset.y > 280) {
 
 _mainView.tableView.userInteractionEnabled = YES;
 }
 
 
 }
 */
@end
