//
//  SwipeCell.h
//  GifLoad
//
//  Created by xxlc on 2017/11/16.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
@interface SwipeCell : UITableViewCell<SwipeViewDelegate,SwipeViewDataSource>
@property (nonatomic ,strong)SwipeView *swipeView;
@end
