//
//  NSNotificationCenter+JKCrashPtotect.m
//  Pods
//
//  Created by Jack on 2017/8/5.
//
//

#import "NSNotificationCenter+JKCrashPtotect.h"
#import <JKCrashProtect/NSObject+JKCrashProtect.h>
#import <JKUBSAspects/JKUBSAspects.h>

@implementation NSNotificationCenter (JKCrashPtotect)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter defaultCenter].isAspected =YES;
        [self JKCrashProtectswizzleMethod:@selector(addObserver:selector:name:object:) withMethod:@selector(JKCrashProtectaddObserver:selector:name:object:) withClass:[NSNotificationCenter class]];
       
    });
}


- (void)JKCrashProtectaddObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    NSString *selectorStr = NSStringFromSelector(aSelector);
    NSString *className = NSStringFromClass([observer class]);
    
    if ([selectorStr hasPrefix:@"_"] || [className hasPrefix:@"_"] || [aName hasPrefix:@"UI"]) {
        [self JKCrashProtectaddObserver:observer selector:aSelector name:aName object:anObject];
        return;
    }
    NSObject *target = (NSObject *)observer;
    target.isAspected = YES;
    [target aspect_hookSelector:aSelector withOptions:JKUBSAspectPositionInstead usingBlock:^(id<JKUBSAspectInfo> data){
       
        NSArray *arguments = [data arguments];
        NSNotification *notif =arguments[0];
        
         NSThread *thread = notif.userInfo[@"thread"];
        thread=[thread isKindOfClass:[NSThread class]]?thread:[NSThread currentThread];
         NSInvocation *invocation = [data originalInvocation];
        SEL selector =invocation.selector;
        id currentTarget = invocation.target;
        [currentTarget performSelector:selector onThread:thread withObject:notif waitUntilDone:NO];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop run];
       
        
    } error:nil];
    [self JKCrashProtectaddObserver:observer selector:aSelector name:aName object:anObject];
}

- (void)postNotification:(nonnull NSNotification *)notification handleThread:(nullable NSThread *)thread{
    NSNotificationName aName =notification.name;
    NSDictionary *userInfo = notification.userInfo;
    id object = notification.object;

    if (userInfo) {
        NSMutableDictionary  *dic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        [dic setObject:thread?:@"" forKey:@"thread"];
        userInfo = [dic copy];
    }else{
        userInfo =@{@"thread":thread?:@""};
            
    }
    
     NSNotification *notif = [[NSNotification alloc] initWithName:aName object:object userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notif];
    

}

- (void)postNotificationName:(nonnull NSNotificationName)aName object:(nullable id)anObject handleThread:(nullable NSThread *)thread{
    NSDictionary *userInfo=nil;
    [self postNotificationName:aName object:anObject userInfo:userInfo handleThread:thread];
}

- (void)postNotificationName:(nonnull NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo handleThread:(nullable NSThread *)thread{

    if (aUserInfo) {
        NSMutableDictionary  *dic = [NSMutableDictionary dictionaryWithDictionary:aUserInfo];
        [dic setObject:thread?:@"" forKey:@"thread"];
        aUserInfo = [dic copy];
    }else{
        
            aUserInfo =@{@"thread":thread?:@""};
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];

}

@end
