//
//  swip.m
//  GifLoad
//
//  Created by xxlc on 2017/11/16.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "swip.h"

@implementation swip

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
- (void)createView{
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.backgroundColor = [UIColor redColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [self.label.font fontWithSize:50];
    self.label.text = @"11";
    self.label.tag = 1;
    [self addSubview:self.label];
}
@end
