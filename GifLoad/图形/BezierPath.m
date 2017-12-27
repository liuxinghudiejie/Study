//
//  BezierPath.m
//  GifLoad
//
//  Created by xxlc on 2017/11/27.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "BezierPath.h"

@implementation BezierPath

- (void)drawRect:(CGRect)rect{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(30, 50, 100, 100)];
    [bezierPath moveToPoint:CGPointMake(60, 60)];
    [bezierPath addLineToPoint:CGPointMake(80, 80)];
    [bezierPath addLineToPoint:CGPointMake(60, 90)];
    [bezierPath closePath];//闭合曲线
    bezierPath.lineCapStyle = kCGLineCapSquare;//端点类型
    bezierPath.lineJoinStyle = kCGLineJoinRound;//线条连接类型
    bezierPath.miterLimit = 1;
    CGFloat dash[] = {20,1};
    [bezierPath setLineDash:dash count:2 phase:0];
    [bezierPath setLineWidth:10];
    
    
    
    
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    bezierPath1.lineWidth = 2;
    [bezierPath1 moveToPoint:CGPointMake(10, 520)];
    [bezierPath1 addLineToPoint:CGPointMake(50, 530)];
    [bezierPath1 addQuadCurveToPoint:CGPointMake(100, 510) controlPoint:CGPointMake(80, 650)];
    [bezierPath1 addCurveToPoint:CGPointMake(200, 530) controlPoint1:CGPointMake(130, 600) controlPoint2:CGPointMake(170, 400)];
    [bezierPath1 addArcWithCenter:CGPointMake(300, 400) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [bezierPath1 closePath];
    
    
   /* //填充色
    [[UIColor redColor] set];
    [bezierPath1 fill];
    //线条颜色
    [[UIColor blackColor]set];
    [bezierPath1 stroke];*/
    
    
    //该动画是小圆点 随着路径走
 /*   CALayer *anilayer = [CALayer layer];
    anilayer.backgroundColor = [UIColor redColor].CGColor;
    anilayer.position = CGPointMake(10, 520);
    anilayer.bounds = CGRectMake(0, 0, 8, 8);
    anilayer.cornerRadius = 4;
    [self.layer addSublayer:anilayer];
    
    CAKeyframeAnimation *keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAni.repeatCount = NSIntegerMax;
    keyFrameAni.path = bezierPath1.CGPath;
    keyFrameAni.duration = 15;
    keyFrameAni.beginTime = CACurrentMediaTime()+1;
    [anilayer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];*/
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.path = bezierPath1.CGPath;
    shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = self.backgroundColor.CGColor;
    [self.layer addSublayer:shapeLayer];
    
    CABasicAnimation *anmiation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmiation.duration = 3.0;
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmiation.fromValue = [NSNumber numberWithFloat:0];
    anmiation.toValue = [NSNumber numberWithFloat:1];
    anmiation.fillMode = kCAFillModeForwards;
    anmiation.removedOnCompletion = NO;
    [shapeLayer addAnimation:anmiation forKey:@"strokeEndAnimation"];
}

@end
