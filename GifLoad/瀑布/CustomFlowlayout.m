//
//  CustomFlowlayout.m
//  GifLoad
//
//  Created by xxlc on 2017/12/12.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "CustomFlowlayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CustomFlowlayout ()
@property (nonatomic ,strong)NSMutableArray *attribures;
/*item的个数*/
@property (nonatomic ,assign)NSInteger numberOfCells;
/*每行item的个数*/
@property (nonatomic ,assign)NSInteger countOfRow;
/*间距*/
@property (nonatomic ,assign)NSInteger padding;
/*间距*/
@property (nonatomic ,assign)NSInteger margin;
/*最小的高*/
@property (nonatomic ,assign)NSInteger minHeight;
/*最大的高*/
@property (nonatomic ,assign)NSInteger maxHeight;
/*item的宽*/
@property (nonatomic ,assign)NSInteger cellWidth;

@property (nonatomic ,strong)NSMutableArray *cellXArray;

@property (nonatomic ,strong)NSMutableArray *cellHArray;

@property (nonatomic ,strong)NSMutableArray *cellYArray;
@end
@implementation CustomFlowlayout

- (NSMutableArray *)attribures{
    if (!_attribures) {
        _attribures = [[NSMutableArray alloc]init];
    }
    return _attribures;
}
#pragma mark ==重写基类方法
//系统在准备对item进行布局前会调用这个方法，我们重写这个方法之后可以在方法里面预先设置好需要用到的变量属性等。比如在瀑布流开始布局前，我们可以对存储瀑布流高度的数组进行初始化。有时我们还需要将布局属性对象进行存储，比如卡片动画式的定制，也可以在这个方法里面进行初始化数组
- (void)prepareLayout{
    [super prepareLayout];
    [self initData];
    [self initCellOfWidth];
    [self initCellOfHeight];
    
    NSLog(@"%@=%@",self.cellXArray,self.cellYArray);
}
//我们需要在这个方法里面返回一个包括UICollectionViewLayoutAttributes对象的数组，这个布局属性对象决定了当前显示的item的大小、层次、可视属性在内的布局属性。同时，这个方法还可以设置supplementaryView和decorationView的布局属性。合理使用这个方法的前提是不要随便返回所有的属性
- (NSArray <__kindof UICollectionViewLayoutAttributes *>*)layoutAttributesForElementsInRect:(CGRect)rect{
    [self initCellOfY];
    NSLog(@"是%@=%@",self.cellXArray,self.cellYArray);
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<self.numberOfCells; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:index];
        [array addObject:att];
    }
    return array;
}
//collectionView可能会为了某些特殊的item请求特殊的布局属性，我们可以在这个方法中创建并且返回特别定制的布局属性。根据传入的indexPath调用[UICollectionViewLayoutAttributes layoutAttributesWithIndexPath: ]方法来创建属性对象，然后设置创建好的属性，包括定制形变、位移等动画效果在内
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = CGRectZero;
    //cell的高
    CGFloat height = [self.cellHArray[indexPath.row] floatValue];
    
    NSInteger minIndex = [self minIndexWithArray:self.cellYArray];
    
    CGFloat tempX = [self.cellXArray[minIndex] floatValue];
    
    CGFloat tempY = [self.cellYArray[minIndex] floatValue];
    
    frame = CGRectMake(tempX, tempY, self.cellWidth, height);
    
    self.cellYArray[minIndex] = @(height + self.padding +tempY);
    
    att.frame = frame;
    NSLog(@"我的frame = %@",NSStringFromCGRect(frame));
    
    return att;
}
//由于collectionView将item的布局任务委托给layout对象，那么滚动区域的大小对于它而言是不可知的。自定义的布局对象必须在这个方法里面计算出显示内容的大小，包括supplementaryView和decorationView在内。
- (CGSize)collectionViewContentSize{
    CGFloat height = [self maxValueWithArray:self.cellYArray];
    NSLog(@"我执行了%f",height);
    return CGSizeMake(kScreenWidth , height);
}
//当collectionView的bounds改变的时候，我们需要告诉collectionView是否需要重新计算布局属性，通过这个方法返回是否需要重新计算的结果。简单的返回YES会导致我们的布局在每一秒都在进行不断的重绘布局，造成额外的计算任务。
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}
#pragma mark === 配置
- (void)initData{
    self.numberOfCells = [self.collectionView numberOfItemsInSection:0];
    self.countOfRow = 2;
    self.padding = 5;
    self.margin = 5;
}

/**
 求每一个cell的宽,以及初始X值
 */
- (void)initCellOfWidth{
    //item的宽度等于屏幕宽减去所有间距除以每行的个数
    self.cellWidth = (kScreenWidth -self.margin*2 - (self.countOfRow - 1)*self.padding)/self.countOfRow;
    //每个item的初始X
    self.cellXArray = [[NSMutableArray alloc]initWithCapacity:self.countOfRow];
    for (int i = 0; i<self.countOfRow; i++) {
        CGFloat temp = self.margin+(self.cellWidth + self.padding)*i;
        [self.cellXArray addObject:@(temp)];
    }

}

/**
 每一个cell的高度
 */
- (void)initCellOfHeight{
    self.cellHArray = [NSMutableArray arrayWithCapacity:self.numberOfCells];
    for (int i = 0; i<self.numberOfCells; i++) {
        CGFloat temp;
        if( i % 2 == 0){
            temp = 100;
        }
        else{
            temp = 120;
        }
        [self.cellHArray addObject:@(temp)];
    }
    
}
/**
 每一个cell的Y
 */
- (void)initCellOfY{
    self.cellYArray = [NSMutableArray arrayWithCapacity:self.countOfRow];
    for (int i = 0; i<self.countOfRow; i++) {
        [self.cellYArray addObject:@(0)];
    }
/**
 找出数组中最大值
 */
}
- (CGFloat)maxValueWithArray:(NSArray *)array{
    if (array.count == 0) {
        return 0;
    }
    CGFloat max = [array[0] floatValue];
    for (int i = 0; i<array.count; i++) {
        CGFloat temp = [array[i] floatValue];
        if (temp>max) {
            max = temp;
        }
    }
    return max;
}
/**
 找出数组中最小值的索引
 */
- (CGFloat)minIndexWithArray:(NSArray *)array{
    if (array.count == 0) {
        return 0;
    }
    CGFloat minValue = [array[0] floatValue];
    CGFloat minIndex = 0;
    for (int i = 0; i<array.count; i++) {
        CGFloat temp = [array[i] floatValue];
        if (temp<minValue) {
            minValue = temp;
            minIndex = i;
        }
    }
    return minIndex;
}
@end
