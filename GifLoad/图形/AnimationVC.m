//
//  AnimationVC.m
//  GifLoad
//
//  Created by xxlc on 17/9/18.
//  Copyright © 2017年 yunfu. All rights reserved.
//
#import "BezierPath.h"
#import "AnimationView.h"
#import "AnimationVC.h"
#import "StudyBezierPath.h"
#import "MaskLayer.h"
#import "waveView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:r / 255.0 green: g / 255.0 blue: b / 255.0 alpha:1.0]
@interface AnimationVC ()
@property (nonatomic ,strong)CAShapeLayer *shapeLayer;
@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(ios 11.0,*)) {
        
        self.navigationController.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = RGB(20, 90, 131);
    //AnimationView *animation = [[AnimationView alloc]initWithFrame:self.view.frame];
   // [self.view addSubview:animation];
   // [self setupLayers];
   /* UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, kScreenWidth-20)];
    [path addLineToPoint:CGPointMake(0, kScreenWidth - 100)];
    [path addQuadCurveToPoint:CGPointMake(kScreenHeight / 3.0, kScreenWidth - 20) controlPoint:CGPointMake(kScreenHeight / 6.0, kScreenWidth - 100)];
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = [UIColor colorWithRed:82.0/255.0 green:177.0/255.0 blue:44.0/255.0 alpha:1.0].CGColor;//设置填充色
    [self.view.layer addSublayer:self.shapeLayer];*/
    
    /*贝塞尔*/
   // [self progressLayer];
    ///***********动画效果 内接三角形*/
    StudyBezierPath *path = [[StudyBezierPath alloc]initWithFrame:CGRectZero];
    path.frame = CGRectMake(0, 100, kScreenWidth, kScreenHeight-100);
    path.backgroundColor = [UIColor whiteColor];
  //  [self.view addSubview:path];
    /*遮盖层*/
    MaskLayer *maskLayer = [[MaskLayer alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100)];
    maskLayer.backgroundColor = [UIColor whiteColor];
   // [self.view addSubview:maskLayer];
    waveView *wave = [[waveView alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
    wave.backgroundColor = [UIColor whiteColor];
    wave.present = 0.1;
     [self.view addSubview:wave];
   
}
- (void)createBezierPath{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(30, 50, 100, 100)];
    [bezierPath moveToPoint:CGPointMake(60, 60)];
}
- (void)progressLayer{
    CGFloat width = 200;
    CAShapeLayer *baseLayer = [CAShapeLayer layer];
    baseLayer.strokeColor = [UIColor whiteColor].CGColor;
    baseLayer.frame = CGRectMake(100, 100, width, width);
    baseLayer.lineWidth = 5;
    baseLayer.fillColor = [UIColor clearColor].CGColor;
    baseLayer.path = [UIBezierPath bezierPathWithOvalInRect:baseLayer.frame].CGPath;
    [self.view.layer addSublayer:baseLayer];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = baseLayer.frame;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.lineWidth = 5;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:baseLayer.frame];
   // path addArcWithCenter:<#(CGPoint)#> radius:<#(CGFloat)#> startAngle:<#(CGFloat)#> endAngle:<#(CGFloat)#> clockwise:<#(BOOL)#>
    [path addArcWithCenter:CGPointMake(200, 200) radius:100 startAngle:M_PI*1.5 endAngle:M_PI clockwise:YES];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:self.shapeLayer];
    [self beginAnmiation];
}
#pragma mark 贝塞尔曲线画圆
- (void)setupCycle{
    
    CGFloat width = 200;
    UIBezierPath *path = [UIBezierPath bezierPath];
    //[path moveToPoint:CGPointMake(0, 100)];
    [path addArcWithCenter:CGPointMake(100, 100) radius:100 startAngle:M_PI*1.5 endAngle:M_PI*1.49999 clockwise:YES];
    //[path addLineToPoint:CGPointMake(100, 200)];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(100, 100, width, width);
    self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.shapeLayer.lineWidth = 5;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:self.shapeLayer];
}
- (void)beginAnmiation{
    CABasicAnimation *anmiation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anmiation.duration = 3.0;
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmiation.fromValue = [NSNumber numberWithFloat:0];
    anmiation.toValue = [NSNumber numberWithFloat:1];
    anmiation.fillMode = kCAFillModeForwards;
    anmiation.removedOnCompletion = NO;
    [self.shapeLayer addAnimation:anmiation forKey:@"strokeEndAnimation"];
}
#pragma mark === 以下是震荡波
- (void)setupLayers{
    CGFloat width = 100;
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(100, 100, width, width);
   //_shapeLayer.position = CGPointMake(width/2, width/2);
    _shapeLayer.fillColor = [UIColor redColor].CGColor;
    _shapeLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)].CGPath;
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.bounds = CGRectMake(0, 0, width, width);
    replicator.position = CGPointMake(width / 2.0, width / 2.0);
    replicator.instanceDelay = 0.5;
    replicator.instanceCount = 8;
    
    [replicator addSublayer:self.shapeLayer];
    [self.view.layer addSublayer:replicator];
   
}

- (void)startAnimation
{
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.fromValue = [NSNumber numberWithFloat:0.6];
    alphaAnim.toValue = [NSNumber numberWithFloat:0.0];
    
    CABasicAnimation *scaleAnim =[CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D t = CATransform3DIdentity;
    CATransform3D t2 = CATransform3DScale(t, 0.0, 0.0, 0.0);
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:t2];
    CATransform3D t3 = CATransform3DScale(t, 1.0, 1.0, 0.0);
    scaleAnim.toValue = [NSValue valueWithCATransform3D:t3];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[alphaAnim, scaleAnim];
    groupAnimation.duration = 4.0;
    groupAnimation.autoreverses = NO;
    groupAnimation.repeatCount = HUGE;
    
    [self.shapeLayer addAnimation:groupAnimation forKey:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
