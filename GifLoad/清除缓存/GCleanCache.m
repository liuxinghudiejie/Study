//
//  GCleanCache.m
//  GifLoad
//
//  Created by xxlc on 2017/12/25.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import "GCleanCache.h"

@implementation GCleanCache

+ (instancetype)shareCache{
    static GCleanCache *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[GCleanCache alloc]init];
    });
    return share;
}
- (CGFloat)fileManagerGetCacheSizeWithFilePath:(NSString *)path{
    return [self loadCacheSize];
}
- (CGFloat)folderSizeWithPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float floderSize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childArray = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childArray) {
            NSString *abPath = [path stringByAppendingPathComponent:fileName];
            NSDictionary<NSString *, id> *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:abPath error:nil];
            floderSize += [attrs fileSize]/1024.0/1024.0;
        }
    }
    return floderSize;
}
- (CGFloat)loadCacheSize{
    self.cacheSize = 0;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //获取指定目录下的子文件，无序的，以递归方式获取，  contentsOfDirectoryAtPath非递归
    NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    for (NSString *file in files) {
        NSString *path = [cachePath stringByAppendingPathComponent:file];//指向目录文件
        NSDictionary<NSString *, id> *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];//获取指定文件的属性
        self.cacheSize += [attrs fileSize]/1024.0/1024.0;
    }
    NSLog(@"%f",self.cacheSize);
    return self.cacheSize;
}

- (void)ClearCacheAction{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
        for (NSString *file in files) {
            NSString *path = [cachePath stringByAppendingPathComponent:file];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                NSError *error;
                [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(cacheSuccess) withObject:nil waitUntilDone:YES];
    });
}
- (void)cacheSuccess{
    NSLog(@"搞定");
}

@end
