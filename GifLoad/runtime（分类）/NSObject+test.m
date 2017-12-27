//
//  NSObject+test.m
//  GifLoad
//
//  Created by xxlc on 17/9/5.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "NSObject+test.h"
#import <objc/message.h>
@implementation NSObject (test)

#pragma mark ===为分类添加属性
//在分类里使用@property声明属性，只是将该属性添加到该类的属性列表，并声明了setter和getter方法，但是没有生成相应的成员变量，(eg:不能直接调用_age,调用的时候会闪退)也没有实现setter和getter方法。所以说分类不能添加属性。但是在分类里使用@property声明属性后，又实现了setter和getter方法，那么在这个类以外可以正常通过点语法给该属性赋值和取值。就是说，在分类里使用@property声明属性，又实现了setter和getter方法后，可以认为给这个类添加上了属性。

- (void)setName:(NSString *)name{
    NSLog(@"%@",name);
    // objc_setAssociatedObject（将某个值跟某个对象关联起来，将某个值存储到某个对象中）
    // object:给哪个对象添加属性
    // key:属性名称
    // value:属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setAge:(NSString *)age{
    NSLog(@"%@",age);
    objc_setAssociatedObject(self, @"age", age, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)name{
    return objc_getAssociatedObject(self, @"name");
}
- (NSString *)age{
    return objc_getAssociatedObject(self, @"age");
}
- (void)setHeight:(NSInteger)height{
    objc_setAssociatedObject(self, @"height", [NSNumber numberWithInteger:height], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)height{
    return [objc_getAssociatedObject(self, @"height") integerValue];
}
- (void)setHair:(NSString *)hair{
    objc_setAssociatedObject(self, @"hair", hair, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)hair{
    return objc_getAssociatedObject(self, @"hair");
}
@end
