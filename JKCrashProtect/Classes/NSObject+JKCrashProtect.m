//
//  NSObject+JKCrashProtect.m
//  Pods
//
//  Created by Jack on 17/4/28.
//
//

#import "NSObject+JKCrashProtect.h"
#import "JKCrashProtect.h"
@implementation NSObject (JKCrashProtect)

-(id)forwardingTargetForSelector:(SEL)aSelector{

    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
   
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *methodName =NSStringFromSelector(aSelector);
    if ([methodName hasPrefix:@"_"]) {
        return nil;
    }
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect: [%@ %@]: unrecognized selector sent to instance",self,NSStringFromSelector(aSelector)];
    NSMethodSignature *signature = [JKCrashProtect instanceMethodSignatureForSelector:@selector(JKCrashProtectCollectCrashMessages:)];
    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
    return signature;
   
    
    
 }



@end
