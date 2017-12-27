//
//  GCleanCache.h
//  GifLoad
//
//  Created by xxlc on 2017/12/25.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GCleanCache : NSObject

@property (nonatomic ,assign) CGFloat cacheSize;

+ (instancetype)shareCache;

/**
 计算文件大小

 @param path 路径
 @return 单个文件大小
 */
- (CGFloat)fileManagerGetCacheSizeWithFilePath:(NSString *)path;

/**
 计算目录文件大小

 @param path 路径
 @return 目录文件大小
 */
- (CGFloat)folderSizeWithPath:(NSString *)path;

/**
 缓存大小

 @return 缓存大小
 */
- (CGFloat)loadCacheSize;

/**
 清除缓存
 */
- (void)ClearCacheAction;
@end
