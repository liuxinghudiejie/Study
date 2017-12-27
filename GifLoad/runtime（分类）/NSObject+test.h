//
//  NSObject+test.h
//  GifLoad
//
//  Created by xxlc on 17/9/5.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (test)

/**
 姓名
 */
@property (nonatomic ,copy) NSString *name;

/**
 年龄
 */
@property (nonatomic ,copy) NSString *age;

/**
 身高
 */
@property (nonatomic ,assign) NSInteger height;
/**
 身高
 */
@property (nonatomic ,copy) NSString *hair;

+(instancetype)modelWithDict:(NSDictionary *)dic;
@end
