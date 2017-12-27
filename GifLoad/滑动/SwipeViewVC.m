//
//  SwipeViewVC.m
//  GifLoad
//
//  Created by xxlc on 2017/11/16.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "UIView+DCAnimationKit.h"
#import "SwipeCell.h"
#import "SwipeViewVC.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SwipeViewVC ()
@property (nonatomic ,assign)CGFloat A1;
@property (nonatomic ,assign)CGFloat K1;
@property (nonatomic ,assign)CGFloat U1;
@property (nonatomic ,assign)CGFloat offsetX;
@property (nonatomic ,assign)CGFloat offset;
@property (nonatomic ,assign)CGFloat w;
@property (nonatomic ,strong)CAShapeLayer *layer;
@property (nonatomic ,strong)UILabel *label;
@end

@implementation SwipeViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.layer = [CAShapeLayer layer];
    self.layer.strokeColor = [UIColor blackColor].CGColor;
    self.layer.lineWidth = 2;
    self.layer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.layer];
   // [self createPath];
    //[self addAnmiation];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 100, 30)];
    self.label.text = @"66666";
    self.label.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.label];
    [self.label tada:NULL];
    [self performSelector:@selector(dosomething) withObject:self afterDelay:3];
    [self performSelector:@selector(dosomething1) withObject:self afterDelay:5];
    [self performSelector:@selector(dosomething2) withObject:self afterDelay:7];
    //[self anmiationB];
   /* CAShapeLayer *shape = [CAShapeLayer layer];
    shape.lineWidth = 5;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.strokeColor = [UIColor yellowColor].CGColor;
    shape.path = bezierPath.CGPath;
    [self.view.layer addSublayer:shape];*/
}
- (void)dosomething{
    [self.label bounce:NULL];
}
- (void)dosomething1{
    [self.label shake:NULL];
}
- (void)dosomething2{
    [self.label hinge:NULL];
}
- (void)createPath{
    
    CGMutablePathRef path = CGPathCreateMutable();
     CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 50);
    CGPathAddArc(path, NULL, 100, 100, 100, -0.5*M_PI, 1.5*M_PI, 0);
    self.layer.path = path;
    CGPathRelease(path);
}
- (void)addAnmiation{
    CABasicAnimation *anmiation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmiation.fromValue = @0;
    anmiation.toValue = @1;
    anmiation.duration = 2;
    anmiation.removedOnCompletion = YES;
   // [self.layer addAnimation:anmiation forKey:@"strokeEndAnimation"];
    
    CABasicAnimation *anmiationPosition = [CABasicAnimation animationWithKeyPath:@"transform"];
    anmiationPosition.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    anmiationPosition.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 0.5)];
    anmiationPosition.beginTime = 2;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
    animationGroup.animations = @[anmiationPosition,opacityAnim];
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = MAXFLOAT;
    [self.layer addAnimation:animationGroup forKey:nil];
}
- (void)anmiationB{
    CABasicAnimation *anmiationPosition = [CABasicAnimation animationWithKeyPath:@"transform"];
    anmiationPosition.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    anmiationPosition.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(10, 10, 10)];
    
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = NO;
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
    animationGroup.animations = @[anmiationPosition,opacityAnim];
    animationGroup.autoreverses = NO;
    animationGroup.duration = 5;
    animationGroup.repeatCount = MAXFLOAT;
    [self.label.layer addAnimation:animationGroup forKey:nil];
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
