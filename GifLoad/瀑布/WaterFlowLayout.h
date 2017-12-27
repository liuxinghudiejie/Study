//
//  WaterFlowLayout.h
//  GifLoad
//
//  Created by xxlc on 2017/12/12.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

@required
//cell的高度
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)layout heightForRowIndex:(NSInteger)index;

@optional
//列数
- (CGFloat)cloumnCountWaterFlowLayout:(WaterFlowLayout *)layout;
//列间距
- (CGFloat)cloumnMarginWaterFlowLayout:(WaterFlowLayout *)layout;
//行间距
- (CGFloat)rowMarginWaterFlowLayout:(WaterFlowLayout *)layout;
//内边距
- (UIEdgeInsets)edgeInsetsWaterFlowLayout:(WaterFlowLayout *)layout;

@end

@interface WaterFlowLayout : UICollectionViewLayout
@property (nonatomic ,weak)id <WaterFlowLayoutDelegate>delegate;

- (NSInteger)columCount;

- (CGFloat)columMargin;

- (CGFloat)rowMargin;

//- (UIEdgeInsets)defaultEdg;
@end
