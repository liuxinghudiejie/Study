//
//  waveView.m
//  GifLoad
//
//  Created by xxlc on 2017/12/21.
//  Copyright © 2017年 yunfu. All rights reserved.
//
#pragma mark =====这是一个水波纹动画
#import "waveView.h"

@interface waveView ()
{
    CAShapeLayer *firstWaveLayer;
    CAShapeLayer *secondWaveLayer;
    CADisplayLink *displayLink;
    //正弦公式 y = Asin(wx+q)+k
    CGFloat a ;//振幅，曲线最高位和最低位的距离
    CGFloat w ;//角速度，控制周期大小，一个单位起伏的个数
    CGFloat k ;//偏距，曲线上下偏移量
    CGFloat q ;//初相，曲线左右偏移量
    CGFloat v ;//去线移动速度
}
@end

@implementation waveView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self initData];
    }
    return self;
}
- (void)createUI{
    firstWaveLayer = [CAShapeLayer layer];
    firstWaveLayer.fillColor = [UIColor greenColor].CGColor;
    firstWaveLayer.strokeColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:firstWaveLayer];
    
    secondWaveLayer = [CAShapeLayer layer];
    secondWaveLayer.fillColor = [UIColor yellowColor].CGColor;
    secondWaveLayer.strokeColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:secondWaveLayer];
    
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}
- (void)initData{
    k = self.bounds.size.height;//k = 0从上往下灌水，k = self.bounds.size.height 从下往上
    q = 0;
    v = 0.5/M_PI;
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}
- (void)updateWave:(CADisplayLink *)link{
    q = q + v;
    [self createFirstWave];
    [self createSecondWave];
}

/**
 画第一个波浪
 */
- (void)createFirstWave{
    CGFloat waterWidth = self.bounds.size.width;
    CGFloat waterHeight = self.bounds.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, k);
    CGFloat y = (1 - self.present) * waterHeight;
     // y = Asin(wx+q)+k
    for (float x = 0.0; x<waterWidth; x++) {
        y = a * sin(x/waterWidth * M_PI+q)+(1 - self.present) * waterHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWidth, waterHeight);
    CGPathAddLineToPoint(path, nil, 0, waterHeight);
    CGPathCloseSubpath(path);
    firstWaveLayer.path = path;
    CGPathRelease(path);
}

/**
 画第二个波浪
 */
- (void)createSecondWave{
    CGFloat waterWidth = self.bounds.size.width;
    CGFloat waterHeight = self.bounds.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, k);
    CGFloat y = (1 - self.present) * waterHeight;
    // y = Asin(wx+q)+k
    for (float x = 0.0; x<waterWidth; x++) {
        y = a * cos(x/waterWidth * M_PI+q)+(1 - self.present) * waterHeight;//余弦
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWidth, waterHeight);
    CGPathAddLineToPoint(path, nil, 0, waterHeight);
    CGPathCloseSubpath(path);
    secondWaveLayer.path = path;
    CGPathRelease(path);
}
- (void)setPresent:(float)present{
    _present = present;
    if (present <= 0.5) {
        a = self.frame.size.height *0.1 *present*2;
    }
    else{
        a = self.frame.size.height *0.1 *(1-present)*2;
    }
}
- (void)dealloc{
    [displayLink invalidate];
}
@end
