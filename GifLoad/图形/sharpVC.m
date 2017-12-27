//
//  sharpVC.m
//  GifLoad
//
//  Created by xxlc on 17/8/25.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "sharpVC.h"
#import <objc/message.h>
#import "NSObject+test.h"
#import "TestObj.h"
#import "Object.h"
#import "CalendarView.h"

@interface sharpVC ()
{
    UIView *bgView;
}
@end

@implementation sharpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor yellowColor];
    bgView.frame = CGRectMake(50, 100, 300, 300);
    [self.view addSubview:bgView];
    
   // TestObj *test = [TestObj alloc];
    TestObj *te = objc_msgSend(objc_getClass("TestObj"), sel_registerName("alloc"));
    te = objc_msgSend(te, sel_registerName("init"));
    [te NOParaMeter];
    id objc = objc_msgSend([NSObject class], @selector(alloc));
    objc = objc_msgSend(objc, @selector(init));
    
    NSObject *obj = [[NSObject alloc]init];
    obj.name = @"大事";
    obj.age = @"33";
    obj.height = 180;
    NSLog(@"默认=%@=%ld",obj.age,obj.height);
    
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = CGRectMake(0, 0, 320, 480);
    image.backgroundColor = [UIColor redColor];
    image.image = [UIImage imageNamed:@"noData"];
    [self.view addSubview:image];
    
    //
    NSDictionary *dic = @{@"name":@"大哥",@"name1":@"大哥1",@"name2":@"大哥2",@"name3":@"大哥3",@"name4":@{@"name2":@"小哥2",@"name1":@"小哥1"},};
    Object *model = [Object modelWithDict:dic];
    Object *model2 = [Object modelWithModel_dic:dic];
    NSLog(@"%@==%@===%@",model.name1,model.name4,model2.name4);
    /*******************************************/
  /*  CalendarView *calendar = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    calendar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:calendar];*/
    
    
    Object *person = [[Object alloc]init];
    [person performSelector:@selector(eat)];
}
- (IBAction)rectSharp:(id)sender {
    [self clearAllPath];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 20, 200, 200)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 2.0;
   // pathLayer.bounds = CGRectMake(0, 0, 100, 20);
    pathLayer.strokeColor = [UIColor orangeColor].CGColor;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.path = path.CGPath;
    [bgView.layer addSublayer:pathLayer];
}
- (IBAction)fangSharp:(id)sender {
    [self clearAllPath];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 20, 200, 200) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(100, 0)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.bounds = CGRectMake(0, 0, 200, 200);
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.fillColor = [UIColor redColor].CGColor;
    pathLayer.path = path.CGPath;
    [bgView.layer addSublayer:pathLayer];
}
- (IBAction)tuoyuan:(id)sender {
    [self clearAllPath];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 160, 100)];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.bounds = CGRectMake(0, 0, 160, 100);
    pathLayer.lineWidth = 2.0;
    pathLayer.strokeColor = [UIColor greenColor].CGColor;
    pathLayer.position = CGPointMake(50, 50);
    pathLayer.fillColor = nil;
    pathLayer.path = path.CGPath;
    [bgView.layer addSublayer:pathLayer];
}
- (IBAction)zhexian:(id)sender {
    [self clearAllPath];
   /* UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    //起点
    [linePath moveToPoint:CGPointMake(20, 20)];
    //其它点
    [linePath addLineToPoint:CGPointMake(160, 160)];
    [linePath addLineToPoint:CGPointMake(180, 50)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.bounds = CGRectMake(0, 0, 200, 200);
    lineLayer.position = CGPointMake(50, 50);
    lineLayer.lineWidth = 2;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    [bgView.layer addSublayer:lineLayer];*/
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:bgView.center radius:20 startAngle:M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 2;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = nil;
    [bgView.layer addSublayer:lineLayer];
}

- (void)clearAllPath{
    for (CALayer *layer in [bgView.layer sublayers]) {
        [layer removeFromSuperlayer];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

