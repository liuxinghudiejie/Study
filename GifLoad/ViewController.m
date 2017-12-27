//
//  ViewController.m
//  GifLoad
//
//  Created by xxlc on 17/8/11.
//  Copyright © 2017年 yunfu. All rights reserved.
//
#import "SAMKeychain.h"
#import <AdSupport/ASIdentifierManager.h>
#import "ViewController.h"
#import "WebViewJavascriptBridge.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "sharpVC.h"
#import "TestObj.h"
#import "AnimationVC.h"
#import "ChooseImageVC.h"
#import "YYFPSLabel.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *KServiceName = @"gifLoad";
static NSString *MainUUID = @"MainUUID";

@interface ViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,retain)WebViewJavascriptBridge *bridge;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)NSArray *vcArray;
@property (nonatomic ,strong)UIView *shotScreenView;
@end

@implementation ViewController


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getcurrentUUID];
    //截屏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ImageAction) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    self.navigationItem.title = @"主页";
    if (@available(ios 11.0,*)) {
        self.navigationController.navigationBar.prefersLargeTitles = true;
         self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    }
//    id nullValue = [NSNull null];
//    NSString *result = [nullValue stringValue];
//    NSLog(@"%@",result);
//    int a = [nullValue intValue];
//    NSLog(@"%d",a);
//    float b = [nullValue intValue];
//    NSLog(@"%f",b);
//    NSNumber *c = [NSNumber numberWithInteger:[nullValue integerValue]];
//    NSLog(@"%@",c);
//    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:result,c, nil];
//    NSLog(@"=%@",array);
    
  /*  UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webview.delegate = self;
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseUrl = [NSURL fileURLWithPath:htmlPath];
    [self.view addSubview:webview];
    [webview loadHTMLString:appHtml baseURL:baseUrl];
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:webview];
    }
    [_bridge setWebViewDelegate:self];
    [self OCToJS];
    [self JSToOC];*/
    YYFPSLabel *label = [[YYFPSLabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 30, 100, 30)];
     [[UIApplication sharedApplication].keyWindow addSubview:label];
    self.dataArray = @[@"runtime",@"画图",@"图片选择",@"滑动",@"瀑布流",@"动画",@"GCD"];
    self.vcArray = @[@"sharpVC",@"AnimationVC",@"ChooseImageVC",@"SwipeViewVC",@"PViewController",@"CAViewController",@"GCDViewController"];
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
}
#pragma mark ====tableview


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       UIViewController *tempVC = [[NSClassFromString(self.vcArray[indexPath.row]) alloc]init];
    tempVC.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:tempVC animated:YES];
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    static CGFloat delay = 0.2f;
    cell.contentView.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
    [UIView animateWithDuration:1 delay:delay+((indexPath.row)*0.06) usingSpringWithDamping:0.6 initialSpringVelocity:0 options:0 animations:^{
        cell.contentView.transform = CGAffineTransformIdentity;
    } completion:NULL];
}*/
#pragma mark =====WebViewJavascriptBridge
- (void)OCToJS{
   // [_bridge callHandler:@"registerAction"];
    //[_bridge callHandler:@"registerAction" data:@"name:da age:17"];
    [_bridge callHandler:@"para" data:@"我大哥" responseCallback:^(id responseData) {
        NSLog(@"OC回调");
    }];
}
- (void)JSToOC{
    [_bridge registerHandler:@"para" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS调用OC，并传值过来");
        NSDictionary *dict = (NSDictionary *)data;
        NSString *str = [NSString stringWithFormat:@"用户名：%@  姓名：%@",dict[@"userId"],dict[@"name"]];
        NSLog(@"JS调用OC，取到参数为： %@",str);
        responseCallback(@"报告，OC已收到JS的请求");

    }];
}
#pragma mark =====webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"网页加载前会调用该方法");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成");
    //创建JSContext对象
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *alertJS = @"alert('test JS')";
    [context evaluateScript:alertJS];
    
   /* context[@"dada"] = ^{
        NSArray *args = [JSContext currentArguments];
        for(id obj in args){
            NSLog(@"%@",obj);
        }
    };*/
//    TestObj *testJO = [TestObj new];
//    context[@"para"] = testJO;
    NSString *jsFunctStr = @"dada('参数1')";
    [context evaluateScript:jsFunctStr];
    NSString *jsTwoValue = @"dada('参数a','参数b')";
    [context evaluateScript:jsTwoValue];
    
    NSString *NoParameter = @"para.NOParaMeter()";
    [context evaluateScript:NoParameter];
    NSString *OneParameter = @"para.OneParaMeter('大哥')";
    [context evaluateScript:OneParameter];
    NSString *TwoParameter = @"para.TestTowParameterSecondParameter('大哥'，'二哥')";
    [context evaluateScript:TwoParameter];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败");
}
#pragma mark   ===截屏事件
- (void)ImageAction{
    self.shotScreenView = [self.view snapshotViewAfterScreenUpdates:YES];
    CGSize size = self.shotScreenView.bounds.size;
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，设置为[UIScreen
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [self.shotScreenView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, kScreenWidth-100, 400)];
    imageView.image = image;
    [[UIApplication sharedApplication].delegate.window addSubview:imageView];
    
}

#pragma mark === 唯一标示
- (void)getcurrentUUID{
    NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier]UUIDString];//广告标识符
    //未存储368708BF-FDB2-4EDF-B3B8-60C83A407303
    NSLog(@"%@==%@",uuid,idfa);
    if (![SAMKeychain passwordForService:KServiceName account:MainUUID]) {
        NSString *uu = [self uuid];
        [SAMKeychain setPassword:uu forService:KServiceName account:MainUUID];
        NSString *reStr = [SAMKeychain passwordForService:KServiceName account:MainUUID];
        NSLog(@"未存储%@",reStr);
    }else{
        NSString *reStr = [SAMKeychain passwordForService:KServiceName account:MainUUID];
        NSLog(@"已存储%@",reStr);
    }
}

/**
 生成字符串，每次调用都会重新生成

 @return uuid
 */
- (NSString *)uuid{
    CFUUIDRef uuid =CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(uuid);
    CFRelease(uuidString);
    return result;
}
//CB55D3DD-D8BE-4DC7-AEF5-A5AFE961311F==84FD7335-B769-4A39-AFC8-2190F8D532E5==67A386D2-2932-4BC7-83DE-454F3C2EF804
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
