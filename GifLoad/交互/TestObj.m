//
//  TestObj.m
//  GifLoad
//
//  Created by xxlc on 17/8/18.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj
- (void)NOParaMeter{
    NSLog(@"没有参数");
}
- (void)OneParaMeter:(NSString *)message{
    NSLog(@"参数1：%@",message);
}

- (void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2  {
    NSLog(@"this is ios TestTowParameter=%@  Second=%@",message1,message2);
}
@end
