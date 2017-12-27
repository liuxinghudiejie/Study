//
//  Object.m
//  GifLoad
//
//  Created by xxlc on 17/9/5.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "Object.h"
#import <objc/message.h>
@implementation Object
#pragma mark == 字典转模型
/*注解：这里在获取模型类中的所有属性名，是采取 class_copyIvarList 先获取成员变量（以下划线开头） ，然后再处理成员变量名->字典中的key(去掉 _ ,从第一个角标开始截取) 得到属性名。
 
 原因：Ivar：成员变量,以下划线开头，Property 属性
 获取类里面属性 class_copyPropertyList
 获取类中的所有成员变量 class_copyIvarList  */
#pragma mark 1、runtime 字典转模型-->字典的 key 和模型的属性不匹配「模型属性数量大于字典键值对数」，这种情况处理如下：
// Runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
// 思路：遍历模型中所有属性->使用运行时
+(instancetype)modelWithDict:(NSDictionary *)dic{
    id objc = [[self alloc]init];
    myDate date = {2017,9,5};
    NSLog(@"%d",date.year);
    // 2.利用runtime给对象中的属性赋值
    /**
     class_copyIvarList: 获取类中的所有成员变量
     Ivar：成员变量
     第一个参数：表示获取哪个类中的成员变量
     第二个参数：表示这个类有多少成员变量，传入一个Int变量地址，会自动给这个变量赋值
     返回值Ivar *：指的是一个ivar数组，会把所有成员属性放在一个数组中，通过返回的数组就能全部获取到。
     count: 成员变量个数
     */
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i<count; i++) {
        // 根据角标，从数组取出对应的成员变量
        Ivar ivar = ivarList[i];
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSLog(@"%@",ivarName);
        // 处理成员变量名->字典中的key(去掉 _ ,从第一个角标开始截取)
        NSString *key = [ivarName substringFromIndex:1];
        //取值
        id value = dic[key];
        // 【如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil】
        // 而报错 (could not set nil as the value for the key age.)
        if (value) {
            // 给模型中属性赋值
            [objc setValue:value forKey:key];
        }
        
    }
    return objc;
}
+(instancetype)modelWithModel_dic:(NSDictionary *)dic{
    id object = [[self alloc]init];
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    //遍历所有的成员变量
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        //获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSString *key = [ivarName substringFromIndex:1];
        id value = dic[key];
        //二级转换：如果字典中还有字典，判断value是否是字典
        if([value isKindOfClass:[NSDictionary class]]&&![ivarType hasPrefix:@"NS"]){
            Class modelClass = NSClassFromString(ivarType);
            if (modelClass) {
                value = [modelClass modelWithModel_dic:value];
            }
        }
        if (value) {
            [object setValue:value forKey:key];
        }
    }
    
    return object;
}
// void(*)()
// 默认方法都有两个隐式参数，
void eat (id self,SEL _cmd){
    NSLog(@"%@ %@",self,NSStringFromSelector(_cmd));
    NSLog(@"我在吃什么");
}
// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel{// 判断对象方法有没有实现
    if ([NSStringFromSelector(sel) isEqualToString:@"eat"]) {
        //动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, sel, (IMP)eat, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}
@end
