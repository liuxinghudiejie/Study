//
//  Object.h
//  GifLoad
//
//  Created by xxlc on 17/9/5.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    int year;
    int month;
    int day;
}myDate;
@interface Object : NSObject
@property (nonatomic ,copy) NSString *name1;
@property (nonatomic ,copy) NSString *name2;
@property (nonatomic ,copy) NSString *name3;
@property (nonatomic ,copy) NSString *name4;
+(instancetype)modelWithModel_dic:(NSDictionary *)dic;
@end
