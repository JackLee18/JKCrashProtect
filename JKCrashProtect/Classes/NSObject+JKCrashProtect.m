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

-(void)setNilValueForKey:(NSString *)key{
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'NSInvalidArgumentException', reason: '[%@ %p setNilValueForKey]: could not set nil as the value for the key %@.'",NSStringFromClass([self class]),self,key];
    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'NSUnknownKeyException', reason: '[%@ %p setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key: %@,value:%@'",NSStringFromClass([self class]),self,key,value];
    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
}

- (nullable id)valueForUndefinedKey:(NSString *)key{

    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[%@ %p valueForUndefinedKey:]: this class is not key value coding-compliant for the key: %@",NSStringFromClass([self class]),self,key];
    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
    return self;
}


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
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect: [%@ %p %@]: unrecognized selector sent to instance",NSStringFromClass([self class]),self,NSStringFromSelector(aSelector)];
    NSMethodSignature *signature = [JKCrashProtect instanceMethodSignatureForSelector:@selector(JKCrashProtectCollectCrashMessages:)];
    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
    return signature;
   
    
    
 }



@end
