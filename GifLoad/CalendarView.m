//
//  CalendarView.m
//  GifLoad
//
//  Created by xxlc on 17/9/7.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "CalendarView.h"

@interface CalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@end

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}
- (void)create{
    [self addSubview:self.collectionView];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.height,20);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:_flowLayout];
        NSInteger width = [UIScreen mainScreen].bounds.size.width/7;
        _flowLayout.itemSize = CGSizeMake(width,width);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self getCurrentMonthForDays];
}
- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = [UILabel new];
    label.center = cell.contentView.center;
    label.bounds = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//获取当前月份的天数
- (NSInteger)getCurrentMonthForDays{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
//获取目标月份的天数
- (NSInteger)getAimMonthForDays:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
@end
