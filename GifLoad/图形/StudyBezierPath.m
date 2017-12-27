//
//  StudyBezierPath.m
//  GifLoad
//
//  Created by xxlc on 2017/11/27.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "StudyBezierPath.h"

@interface StudyBezierPath ()
@property (nonatomic ,strong)CAShapeLayer *bigArcLayer;
@property (nonatomic ,strong)CAShapeLayer *smallArcLayer;
@property (nonatomic ,strong)CAShapeLayer *upThreeLayer;
@property (nonatomic ,strong)CAShapeLayer *downThreeLayer;
@end
@implementation StudyBezierPath

//- (void)drawRect:(CGRect)rect{
//    //贝塞尔画路径
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    [bezierPath moveToPoint:CGPointMake(100, 100)];
//    [bezierPath addArcWithCenter:CGPointMake(150, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    CAShapeLayer *shape = [CAShapeLayer layer];
//    shape.lineWidth = 5;
//    shape.fillColor = self.backgroundColor.CGColor;
//    shape.strokeColor = [UIColor yellowColor].CGColor;
//    shape.path = bezierPath.CGPath;
//   // [self.layer addSublayer:shape];
//
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.duration = 3;
//    animation.fromValue = [NSNumber numberWithFloat:0];
//    animation.toValue = [NSNumber numberWithFloat:1];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    animation.removedOnCompletion = NO;
// //   [shape addAnimation:animation forKey:@"strokeEndAnimation"];
//
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGFloat xCenter = 200;
//    CGFloat ycenter = 300;
//    [[UIColor greenColor]set];
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    CGContextSetLineWidth(ctx, 5);
//    CGContextAddArc(ctx, xCenter, ycenter, 100, M_PI*1.5/*-M_PI*0.5*/, 1.4*M_PI, 0);
//  //  CGContextStrokePath(ctx);
//
//    /*画路径*/
//    //1.获取图形上下文
//    //   CGContextRef ctx1=UIGraphicsGetCurrentContext();
//
//    //2.绘图
//    //2.1创建一条直线绘图的路径
//    //注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
//        CGMutablePathRef path=CGPathCreateMutable();
//       //2.2把绘图信息添加到路径里
//       // CGPathMoveToPoint(path, NULL, 20, 20);
//      //  CGPathAddLineToPoint(path, NULL, 200, 300);
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
//    CGPathAddArc(path, &transform, 100, 200, 100, -0.5*M_PI, 1.5*M_PI, NO);
//        //2.3把路径添加到上下文中
//        //把绘制直线的绘图信息保存到图形上下文中
//     //   CGContextAddPath(ctx1, path);
//
//        //3.渲染
//      //  CGContextStrokePath(ctx1);
//
//
//
//    CAShapeLayer *shape1 = [CAShapeLayer layer];
//    shape1.lineWidth = 5;
//    shape1.fillColor = self.backgroundColor.CGColor;
//    shape1.strokeColor = [UIColor yellowColor].CGColor;
//    shape1.path = path;
//     [self.layer addSublayer:shape1];
//
//    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation1.duration = 3;
//    animation1.fromValue = [NSNumber numberWithFloat:0];
//    animation1.toValue = [NSNumber numberWithFloat:1];
//    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    animation1.removedOnCompletion = NO;
//     [shape1 addAnimation:animation1 forKey:@"strokeEndAnimation"];
//
//    //4.释放前面创建的两条路径
//    //第一种方法
//    CGPathRelease(path);
//    //第二种方法
//    //    CFRelease(path);
//}
static  CGFloat const X = 200;//圆中心X
static  CGFloat const Y = 200;//圆中心Y
static  CGFloat const radius = 150;//大圆半径
static  CGFloat const smallRadius = 130;//小圆半径

- (void)drawRect:(CGRect)rect{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.bigArcLayer = [self createLayer];
    [self.layer addSublayer:self.bigArcLayer];
    
    self.smallArcLayer = [self createLayer];
    [self.layer addSublayer:self.smallArcLayer];
    
    self.upThreeLayer = [self createLayer];
    [self.layer addSublayer:self.upThreeLayer];
    
    self.downThreeLayer = [self createLayer];
    [self.layer addSublayer:self.downThreeLayer];
    
    [self createBigArc];
}

/**
 外圆
 */
- (void)createBigArc{
   /* UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(X, Y) radius:radius startAngle:1.5*M_PI endAngle:-0.5*M_PI clockwise:0];//和下面效果一致*/
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, X, Y, radius,1.5*M_PI, -0.5*M_PI, 1);
    self.bigArcLayer.path = path;
    CGPathRelease(path);
    
    CABasicAnimation *anmiation = [self addAnmiationStroken];
    anmiation.duration = 4;
    [self.bigArcLayer addAnimation:anmiation forKey:@"strokeEndAnimation"];
    [self performSelector:@selector(createSmallArc) withObject:nil afterDelay:2];//延时执行，保持大圆先走，小圆延迟两秒再走
    
}

/**
 内圆
 */
- (void)createSmallArc{
    
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathAddArc(path1, NULL, X, Y, smallRadius, M_PI, -1*M_PI, 1);//开始的角度是1.5*M_PI,结束的是-0.5*M_PI，逆时针（顺时针反过来）
    self.smallArcLayer.path = path1;
    CGPathRelease(path1);
    
    CABasicAnimation *anmiation1 = [self addAnmiationStroken];
    anmiation1.duration = 2;
    [self.smallArcLayer addAnimation:anmiation1 forKey:@"strokeEndAnimation"];
    [self performSelector:@selector(createThree) withObject:nil afterDelay:2];//延时执行,小圆画完，再走三角形
}
- (void)createThree{
    [self createUp];
    [self createDown];
}
/**
 上三角
 */
- (void)createUp{
    //圆内接三角形的边是圆半径的根3倍
    CGFloat widthThree = smallRadius/2*sqrt(3);//内接三角形的宽的一半
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, X, Y-smallRadius);//移动到初始点（上顶点），上顶点的横坐标为圆心的横坐标，纵坐标为圆心的纵左标减去小圆半径（这里为小圆的内接三角形）
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, X-widthThree, Y+smallRadius/2);//画线到左顶点，该点的横坐标为圆心的横坐标减去三角形宽的一半，纵坐标为圆心的纵坐标加小圆半径的一半
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, X+widthThree, Y+smallRadius/2);//画线到右顶点，该点的横坐标为圆心的横坐标加三角形宽的一半，纵坐标为圆心的纵坐标加小圆半径的一半
    CGPathCloseSubpath(path);//线路闭合
   
    self.upThreeLayer.path = path;
    self.upThreeLayer.lineJoin = kCALineJoinRound;
    CGPathRelease(path);
    CABasicAnimation *anmiation1 = [self addAnmiationStroken];
    anmiation1.duration = 4;
    [self.upThreeLayer addAnimation:anmiation1 forKey:@"strokeEndAnimation"];
}

/**
 下三角
 */
- (void)createDown{
    //圆内接三角形的边是圆半径的根3倍
    CGFloat widthThree = smallRadius/2*sqrt(3);//内接三角形的宽的一半
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, &CGAffineTransformIdentity, X, Y+smallRadius);//移动到初始点（下顶点），下顶点的横坐标为圆心的横坐标，纵坐标为圆心的纵左标加小圆半径（这里为小圆的内接三角形）
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, X-widthThree, Y-smallRadius/2);//画线到左顶点，该点的横坐标为圆心的横坐标减去三角形宽的一半，纵坐标为圆心的纵坐标减小圆半径的一半
    CGPathAddLineToPoint(path, &CGAffineTransformIdentity, X+widthThree, Y-smallRadius/2);//画线到右顶点，该点的横坐标为圆心的横坐标加三角形宽的一半，纵坐标为圆心的纵坐减加小圆半径的一半
    CGPathCloseSubpath(path);//线闭合
    self.downThreeLayer.path = path;
    self.downThreeLayer.fillColor = [UIColor clearColor].CGColor;//防止重合的地方被遮盖
    self.downThreeLayer.lineJoin = kCALineJoinRound;//防止交点过尖，超出圆
    CGPathRelease(path);//必须释放
    
    CABasicAnimation *anmiation1 = [self addAnmiationStroken];
    anmiation1.duration = 4;
    [self.downThreeLayer addAnimation:anmiation1 forKey:nil];
}

/**
 动画效果
 */
- (CABasicAnimation *)addAnmiationStroken{
    CABasicAnimation *anmiation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmiation.fromValue = @0;
    anmiation.toValue = @1;
    return anmiation;
    
}

/**
 创建一个CAShapeLayer
 */
- (CAShapeLayer *)createLayer{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 5;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor greenColor].CGColor;
    return layer;
}
@end
