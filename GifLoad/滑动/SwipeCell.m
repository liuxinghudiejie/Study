//
//  SwipeCell.m
//  GifLoad
//
//  Created by xxlc on 2017/11/16.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "SwipeCell.h"
#import "swip.h"
@implementation SwipeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self swipeView];
    }
    return self;
}
- (void)setupView{
    self.swipeView = [[SwipeView alloc]initWithFrame:self.bounds];
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    [self addSubview:self.swipeView];
}
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView{
    return 3;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        swip *swipp = [[swip alloc]initWithFrame:swipeView.bounds];
        view = swipp;
    }
    return view;
}
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return CGSizeMake(300, 100);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
