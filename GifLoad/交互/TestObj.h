//
//  TestObj.h
//  GifLoad
//
//  Created by xxlc on 17/8/18.
//  Copyright © 2017年 yunfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSOCProtocol <JSExport>

- (void)NOParaMeter;
- (void)OneParaMeter:(NSString *)message;

- (void)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;

@end

@interface TestObj : NSObject<JSOCProtocol>


@end
