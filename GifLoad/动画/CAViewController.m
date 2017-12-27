//
//  CAViewController.m
//  GifLoad
//
//  Created by xxlc on 2017/12/4.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "CAViewController.h"
#import "Masonry.h"
#import "SDAutoLayout.h"
@interface CAViewController ()
@property (weak, nonatomic) IBOutlet UILabel *TopLab;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (nonatomic ,retain) UILabel *firLab;
@property (nonatomic ,retain) UILabel *secLab;
@end

@implementation CAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];

    label.sd_layout.leftEqualToView(self.view).offset(100).topEqualToView(self.view).offset(150).widthIs(100).heightIs(30);
    UILabel *label1 = [UILabel new];
    label1.backgroundColor = [UIColor greenColor];
    label1.text = @"sadasdasdasdasdasd";
    [self.view addSubview:label1];
    //label1.sd_layout.leftSpaceToView(label, 20).topEqualToView(self.view).offset(150).rightEqualToView(self.view).offset(-10).heightIs(30);
    [label1 sizeThatFits:<#(CGSize)#>]
    self.leftLab = label;
    self.rightLab = label1;
    
    [self.leftLab.layer addAnimation:[self frameAnimation] forKey:nil];
    [self.view layoutIfNeeded];
    
}
- (IBAction)firstAction:(id)sender {
    //改变position
 /*   CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:self.TopLab.center];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.leftLab.layer addAnimation:animation forKey:@"PostionAni"];*/
    [UIView animateWithDuration:2 animations:^{
        self.leftLab.sd_layout.widthIs(200);
        [self.view layoutIfNeeded];
    }];
   
    
}
- (IBAction)secondAction:(id)sender {
    NSLog(@"大小是%@",NSStringFromCGRect(self.rightLab.frame));
    //弹簧效果
    CASpringAnimation *ani = [CASpringAnimation animationWithKeyPath:@"bounds"];
    ani.mass = 10;//质量，影响图层运动时的弹簧惯性。值越大，弹簧拉伸和压缩的幅度越大
    ani.stiffness = 5000;//刚度系数，越大，形变产生的力就越大，运动越快
    ani.initialVelocity = 5;//初始速率，初始速度大小，正数时，速度方向与=运行方向一致，反之相反
    ani.damping = 100;//阻尼系数，阻止弹簧伸缩的系数，值越大，停止越快
    ani.duration = 5;
    ani.toValue = [NSValue valueWithCGRect:CGRectMake(0, 200, 200, 400)];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    
    UILabel *myTest1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, 60, 40)];
    myTest1.backgroundColor = [UIColor blueColor];
    myTest1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:myTest1];
    CABasicAnimation *opacity = [self opacityAnimation:1];
    CABasicAnimation *translation = [self moveValue:[NSNumber numberWithInteger:200] time:2];
    CABasicAnimation *scale = [self scaleAnimation:1 orign:2];
    CABasicAnimation *rotation = [self rotation];
    CAAnimationGroup *group = [self groupAnimation:@[opacity,translation,scale]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 300, 100, 200)];
    CAKeyframeAnimation *animation = [self keyframeAnimation:path.CGPath];
    [myTest1.layer addAnimation:rotation forKey:nil];
    NSLog(@"大小是%@",NSStringFromCGRect(self.rightLab.frame));
    
}
- (IBAction)thirdAction:(id)sender {
   
}

/**
 闪烁动画（修改透明度）

 @param time 持续时间
 @return 动画
 */
- (CABasicAnimation *)opacityAnimation:(float)time{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1];
    animation.toValue = [NSNumber numberWithFloat:0];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

/**
 横向，纵向移动
 */
- (CABasicAnimation *)moveValue:(NSNumber *)value time:(float)time{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];//纵向就修改成y
    animation.toValue = value;
    animation.duration = time;
    animation.removedOnCompletion = NO;//不返回原位置
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

/**
 缩放动画
 */
- (CABasicAnimation *)scaleAnimation:(float)multiple orign:(float)oriMultiple{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithFloat:multiple];
    animation.toValue = [NSNumber numberWithFloat:oriMultiple];
    animation.removedOnCompletion = NO;//不返回原位置
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

/**
 组合动画
 */
- (CAAnimationGroup *)groupAnimation:(NSArray *)animationArray{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = animationArray;
    animation.removedOnCompletion = NO;//不返回原位置
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 3;
    return animation;
}

/**
 路径动画

 @param path 路径
 @return 动画
 */
- (CAKeyframeAnimation *)keyframeAnimation:(CGPathRef)path{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 3;
    animation.path = path;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}
- (CABasicAnimation *)rotation{
    CATransform3D rotation = CATransform3DMakeRotation(360, 0, 0, 1);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotation];
    animation.removedOnCompletion = NO;//不返回原位置
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    return animation;
    
}
- (CABasicAnimation *)frameAnimation{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform";
    animation.fromValue = [NSValue valueWithCGRect:self.leftLab.frame];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(self.leftLab.frame.origin.x+100, self.leftLab.frame.origin.y+20, self.leftLab.frame.size.width+10 , self.leftLab.frame.size.height+10)];
    return animation;
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
