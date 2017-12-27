//
//  PFlowLatout.m
//  GifLoad
//
//  Created by xxlc on 2017/11/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "PFlowLatout.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:r / 255.0 green: g / 255.0 blue: b / 255.0 alpha:1.0]

@interface PFlowLatout ()

//sections数量
@property (nonatomic ,assign)NSInteger numberOfSections;
//个数
@property (nonatomic ,assign)NSInteger numberOfCells;
//每排的个数
@property (nonatomic ,assign)NSInteger counts;
//间距
@property (nonatomic ,assign)NSInteger padding;
//最小的高
@property (nonatomic ,assign)NSInteger cellMinHeight;
//最大的高
@property (nonatomic ,assign)NSInteger cellMaxHeight;
//宽
@property (nonatomic ,assign)NSInteger cellWidth;
/**/
@property (nonatomic ,strong)NSMutableArray *cellXArray;

@property (nonatomic ,strong)NSMutableArray *cellHArray;

@property (nonatomic ,strong)NSMutableArray *cellYArray;

@end

@implementation PFlowLatout

#pragma mark ---基类重写

/**
 预加载layout，只会执行一次
 */
- (void)prepareLayout{
    [super prepareLayout];
    [self initData];
    [self initCellWidth];
    [self initCellHeight];
    
    NSLog(@"%@=%@",self.cellXArray,self.cellYArray);
}

/**
 collectionView的contentsize
 */
- (CGSize)collectionViewContentSize{
    CGFloat height = [self maxCellYArrayWithArray:self.cellYArray];
    NSLog(@"我执行了%f",height);
    return CGSizeMake(kScreenWidth , height);
}

/**
 为每一个cell绑定一个layout属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    [self initcellYArray];
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i=0; i<self.numberOfCells; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:index];
        [array addObject:att];
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame = CGRectZero;
    
    CGFloat cellHeight = [self.cellHArray[indexPath.row] floatValue];
    
    NSInteger minYIndex = [self minCellYArrayWithArray:self.cellYArray];
    
    CGFloat tempX = [self.cellXArray[minYIndex] floatValue];
    
    CGFloat tempY = [self.cellYArray[minYIndex] floatValue];
    
    frame = CGRectMake(tempX, tempY, self.cellWidth, cellHeight);
    
    self.cellYArray[minYIndex] = @(tempY+cellHeight+self.padding);
    
    att.frame = frame;
    NSLog(@"我的frame = %@",NSStringFromCGRect(frame));
    return att;
}
- (void)initData{
    self.numberOfSections = [self.collectionView numberOfSections];
    self.numberOfCells = [self.collectionView numberOfItemsInSection:0];
    self.counts = 2;
    self.padding = 10;
    self.cellMinHeight = 50;
    self.cellMaxHeight = 200;
}
/**
 求每一个cell的宽度
 */
- (void)initCellWidth{
    self.cellWidth = (kScreenWidth - (self.counts - 1)*self.padding)/self.counts;
    self.cellXArray = [[NSMutableArray alloc]initWithCapacity:self.counts];
    for (int i = 0; i<self.counts; i++) {
        CGFloat temp = (self.cellWidth + self.padding)*i;
        NSLog(@"第%d个的宽是%f",i,temp);
        [self.cellXArray addObject:@(temp)];
    }
}
/**
 随机生成每个cell的高度
 */
- (void)initCellHeight{
    self.cellHArray = [[NSMutableArray alloc]initWithCapacity:self.numberOfCells];
    for (int i =0; i<self.numberOfCells; i++) {
        CGFloat cellHeight = 100;//arc4random()%(self.cellMaxHeight - self.cellMinHeight)+self.cellMinHeight;
        if (i == 3) {
            cellHeight = 150;
        }
        [self.cellHArray addObject:@(cellHeight)];
    }
}
/**
 初始化每列cell的Y坐标
 */
- (void)initcellYArray{
    self.cellYArray = [[NSMutableArray alloc]initWithCapacity:self.counts];
    for (int i = 0; i<self.counts; i++) {
        [self.cellYArray addObject:@(0)];
    }
}
/**
 找到数组中最大值
 */
- (CGFloat)maxCellYArrayWithArray:(NSMutableArray *)array{
    if (array.count == 0) {
        return 0;
    }
    CGFloat max = [array[0] floatValue];
    for (NSNumber *number in array) {
        CGFloat temp = [number floatValue];
        if (temp>max) {
            max = temp;
        }
    }
    return max;
}
/**
 找到数组中最小值的索引
 */
- (CGFloat)minCellYArrayWithArray:(NSMutableArray *)array{
    if (array.count == 0) {
        return 0;
    }
    NSInteger minIndex = 0;
    CGFloat min = [array[0]floatValue];
    for (int i = 0; i<array.count; i++) {
        CGFloat temp = [array[i] floatValue];
        if (min > temp) {
            min = temp;
            minIndex = i;
        }
    }
    return minIndex;
}
@end
