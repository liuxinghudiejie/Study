//
//  PViewController.m
//  GifLoad
//
//  Created by xxlc on 2017/11/29.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "PViewController.h"
#import "PCollectionViewCell.h"
#import "PFlowLatout.h"
#import "CustomFlowlayout.h"
#import "WaterFlowLayout.h"
#import "ScaleFlowLayout.h"
#import "GCleanCache.h"
#define RGB(r,g,b) [UIColor colorWithRed:r / 255.0 green: g / 255.0 blue: b / 255.0 alpha:1.0]
@interface PViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate>

@end

@implementation PViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    ScaleFlowLayout *flawlayout = [[ScaleFlowLayout alloc]init];
   // flawlayout.delegate = self;
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flawlayout];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectView];
    [collectView registerNib:[UINib nibWithNibName:@"PCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    CGFloat size = [[GCleanCache shareCache] loadCacheSize];
    NSLog(@"wwwww%f",size);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.title.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    cell.title.backgroundColor = [UIColor redColor];
    cell.title.text = [NSString stringWithFormat:@"我是第%ld个",indexPath.row];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.y/200;
    //[scrollView setContentOffset:CGPointMake(0, page*100) animated:YES];
    NSLog(@"便宜%@==%d",NSStringFromCGPoint(scrollView.contentOffset),page);
}
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)layout heightForRowIndex:(NSInteger)index{
    /*if (index%2 == 0) {
        return 100;
    }
    else{
        return 150;
    }*/
    return 200;
}
- (UIEdgeInsets)edgeInsetsWaterFlowLayout:(WaterFlowLayout *)layout{
    return UIEdgeInsetsMake(10, 10, 10, 10 );
}
- (CGFloat)cloumnCountWaterFlowLayout:(WaterFlowLayout *)layout{
    return 1;
}
- (CGFloat)cloumnMarginWaterFlowLayout:(WaterFlowLayout *)layout{
    return 5;
}
- (CGFloat)rowMarginWaterFlowLayout:(WaterFlowLayout *)layout{
    return 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
