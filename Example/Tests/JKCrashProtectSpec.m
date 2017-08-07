//
//  JKCrashProtectSpec.m
//  JKCrashProtect
//
//  Created by Jack on 2017/8/7.
//  Copyright 2017年 HHL110120. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "JKCrashProtect.h"


SPEC_BEGIN(JKCrashProtectSpec)

describe(@"JKCrashProtect", ^{
    context(@"test functions", ^{
        it(@"unrecognize to selector", ^{
           NSString *str = @"gotoUSA";
            SEL selector = NSSelectorFromString(str);
            NSObject *obj = [NSObject new];
            [obj performSelector:selector withObject:nil afterDelay:0];
        });
       
    });
});

SPEC_END
