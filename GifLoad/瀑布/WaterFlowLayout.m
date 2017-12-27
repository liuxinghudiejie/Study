//
//  WaterFlowLayout.m
//  GifLoad
//
//  Created by xxlc on 2017/12/12.
//  Copyright © 2017年 yunfu. All rights reserved.
//
#pragma mark ========这是一个瀑布流的封装
#import "WaterFlowLayout.h"
/*列数*/
static const CGFloat columCount = 3;
/*列间距*/
static const CGFloat columMargin = 10;
/*行间距*/
static const CGFloat rowMargin = 10;
/*边缘间距*/
//static const UIEdgeInsets defaultEdg = {10,10,10,10};

@interface WaterFlowLayout ()
/*布局属性数组*/
@property (nonatomic ,strong)NSMutableArray *attrsArray;

/*存放所有列的高度数组*/
@property (nonatomic ,strong)NSMutableArray *heightArray;


@end
@implementation WaterFlowLayout
#pragma mark === 数组初始化
- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
- (NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
#pragma mark ===配置
- (void)initData{
    //如果刷新布局就会重新调用prepareLayout这个方法,所以要先把高度数组清空
    [self.heightArray removeAllObjects];
    [self.attrsArray removeAllObjects];
    for (int i = 0; i<self.columCount; i++) {
        [self.heightArray addObject:@(self.defaultEdg.top)];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:att];
    }
}
#pragma mark ==== 重写方法
- (void)prepareLayout{
    [super prepareLayout];
    [self initData];
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //找到每一列的最短item的高度的索引和值
    NSInteger minIndex = 0;
    CGFloat minValue = [self.heightArray[0] floatValue];
    for (int i = 0; i<self.columCount; i++) {
        CGFloat temp = [self.heightArray[i]floatValue];
        if (minValue>temp) {
            minValue = temp;
            minIndex = i;
        }
    }
    CGFloat h = [self.delegate waterFlowLayout:self heightForRowIndex:indexPath.item];
    CGFloat w = (self.collectionView.frame.size.width - self.defaultEdg.left - self.defaultEdg.right - (self.columCount-1)*columMargin)/self.columCount;
    CGFloat x = self.defaultEdg.left+(w+columMargin)*minIndex;
    CGFloat y = minValue;
    //如果不是第一行，就加上行边距
    if (y != self.defaultEdg.top) {
        y = y+rowMargin;
    }
    att.frame = CGRectMake(x, y, w, h);
    self.heightArray[minIndex] = @(y+h);
    return att;
}
- (CGSize)collectionViewContentSize{
    CGFloat maxValue = [self.heightArray[0] floatValue];
    for (int i = 0; i<self.columCount; i++) {
        CGFloat temp = [self.heightArray[i]floatValue];
        if (maxValue<temp) {
            maxValue = temp;
        }
    }
    return CGSizeMake(0, maxValue+self.defaultEdg.bottom);
}

#pragma mark ====代理
- (NSInteger)columCount{
    if ([self.delegate respondsToSelector:@selector(cloumnCountWaterFlowLayout:)]) {
        return [self.delegate cloumnCountWaterFlowLayout:self];
    }
    else{
        return columCount;
    }
}
- (CGFloat)columMargin{
    if ([self.delegate respondsToSelector:@selector(cloumnMarginWaterFlowLayout:)]) {
        return [self.delegate cloumnMarginWaterFlowLayout:self];
    }
    else{
        return columMargin;
    }
}
- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginWaterFlowLayout:)]) {
        return [self.delegate rowMarginWaterFlowLayout:self];
    }
    else{
        return rowMargin;
    }
}
- (UIEdgeInsets)defaultEdg{
    NSLog(@"调用我内边距了");
    if ([self.delegate respondsToSelector:@selector(edgeInsetsWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsWaterFlowLayout:self];
    }
    else{
        return UIEdgeInsetsMake(10,10,10,10);
    }
}
@end
