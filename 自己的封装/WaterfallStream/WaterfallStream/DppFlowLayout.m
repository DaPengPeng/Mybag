//
//  DppFlowLayout.m
//  WaterfallStream
//
//  Created by bever on 16/4/23.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "DppFlowLayout.h"
//默认列数
static const NSInteger columnCount = 3;

//每一列之间的间距
static const CGFloat columnSpaces = 15;

//每一行之间的间距
static const CGFloat lineSpaces = 15;

//边缘间距
static const UIEdgeInsets edgeInsets = {10, 10, 10, 10};

@interface DppFlowLayout ()

@property (nonatomic,strong) NSMutableArray *columHeight;
@property (nonatomic,strong) NSMutableArray *attrsArray;

@end

@implementation DppFlowLayout

//懒加载
- (NSMutableArray *)columHeight {

    if (!_columHeight) {
        
        _columHeight = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _columHeight;
}

- (NSMutableArray *)attrsArray {

    if (!_attrsArray) {
        
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

//实现prepareLayout方法
- (void)prepareLayout {

    [super prepareLayout];
    
    [self.columHeight removeAllObjects];
    
    //记录每一列的最大值
    for (int i = 0; i < columnCount; i++) {
        
        //一开始每一列的最大距离就是到上边界的距离
        [self.columHeight addObject:@(edgeInsets.top)];
    }
    
    //每一个单元格的布局属性
    [self.attrsArray removeAllObjects];
    
    //创建每一个单元格的布局属性
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //创建位置对应的单元格布局属性
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attributes];
    }
    
}

//返回所有单元格的布局属性数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attrsArray;
}


//返回每个单元格的布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    //frame的计算
    CGFloat ItemWidth = ([UIScreen mainScreen].bounds.size.width-(edgeInsets.left+edgeInsets.right+2*lineSpaces))/3;
    
    //生成随机数arc4random()可能很大也可能很小
    //arc4random_uniform()指定随机范围
    CGFloat ItemHeight = 50 +arc4random_uniform(100);
    
    //确定x的坐标需要知道最短的一列（假设最短的一列是第零列）
    NSInteger minLineIndex = 0;
    CGFloat minLine = [self.columHeight[0] doubleValue];
    for (int i = 1; i < columnCount; i++) {
        
        if (minLine > [self.columHeight[i] doubleValue]) {
            minLine = [self.columHeight[i] doubleValue];
            minLineIndex = i;
        }
    }
    CGFloat ItemX = minLineIndex * (ItemWidth+lineSpaces) + edgeInsets.left;
    
    
    //y的坐标是self.columHeight中最短的加上一个最小间距
    CGFloat ItemY = minLine;
    if (minLine != edgeInsets.top) {
        
        ItemY = minLine + columnSpaces;
    }
    
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(ItemX, ItemY, ItemWidth, ItemHeight);
    
    //更新数组中最短列的Y值
    self.columHeight[minLineIndex] = @(CGRectGetMaxY(attributes.frame));
    //没有这一步的话，会叠加在第一个单元格之上
    
    return attributes;
}

//返回尺寸
- (CGSize)collectionViewContentSize {

    CGFloat maxColumnHeight = [self.columHeight[0] doubleValue];
    for (int i = 1; i < columnCount; i++) {
        
        //取得第i列的高度
        CGFloat columnHeight = [self.columHeight[i] doubleValue];
        if (columnHeight > maxColumnHeight) {
            
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight+edgeInsets.bottom);
}

@end
