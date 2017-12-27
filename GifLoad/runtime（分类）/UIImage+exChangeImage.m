//
//  UIImage+exChangeImage.m
//  GifLoad
//
//  Created by xxlc on 17/9/4.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "UIImage+exChangeImage.h"
#import <objc/message.h>
@implementation UIImage (exChangeImage)
+ (void)load{
    //获取imageNamed方法地址
    //获取某个类的方法
    //class_getClassMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method yx_imageNamedMethod = class_getClassMethod(self, @selector(yx_imageNamed:));
    //交换方法
     method_exchangeImplementations(imageNamedMethod, yx_imageNamedMethod);
    
}
+ (UIImage *)yx_imageNamed:(NSString *)name{
    UIImage *image = [UIImage yx_imageNamed:name];
    if (image) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    return image;
}

@end
