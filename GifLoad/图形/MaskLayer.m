//
//  MaskLayer.m
//  GifLoad
//
//  Created by xxlc on 2017/12/1.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "MaskLayer.h"

@implementation MaskLayer

- (void)drawRect:(CGRect)rect{
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    image.backgroundColor = [UIColor blueColor];
    [self addSubview:image];
    /*CALayer *blueLayer = [CALayer layer];
    blueLayer.bounds = CGRectMake(0, 0, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.position = image.center;*/
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:image.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(50, 50)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = image.bounds;
    maskLayer.path = path.CGPath;
    maskLayer.fillMode = kCAFillModeRemoved;
    image.layer.mask = maskLayer;
}

@end
