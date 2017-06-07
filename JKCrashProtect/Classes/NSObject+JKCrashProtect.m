//
//  NSObject+JKCrashProtect.m
//  Pods
//
//  Created by Jack on 17/4/28.
//
//

#import "NSObject+JKCrashProtect.h"
#import "JKCrashProtect.h"
#import <objc/runtime.h>

@implementation NSObject (JKCrashProtect)

-(void)setNilValueForKey:(NSString *)key{
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'NSInvalidArgumentException', reason: '[%@ %p setNilValueForKey]: could not set nil as the value for the key %@.'",NSStringFromClass([self class]),self,key];
    JKCrashProtect *protect = [JKCrashProtect new];
    protect.crashMessages =crashMessages;
    [protect JKCrashProtectCollectCrashMessages];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'NSUnknownKeyException', reason: '[%@ %p setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key: %@,value:%@'",NSStringFromClass([self class]),self,key,value];
    JKCrashProtect *protect = [JKCrashProtect new];
    protect.crashMessages =crashMessages;
    [protect JKCrashProtectCollectCrashMessages];
}

- (nullable id)valueForUndefinedKey:(NSString *)key{

    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[%@ %p valueForUndefinedKey:]: this class is not key value coding-compliant for the key: %@",NSStringFromClass([self class]),self,key];
    JKCrashProtect *protect = [JKCrashProtect new];
    protect.crashMessages =crashMessages;
    [protect JKCrashProtectCollectCrashMessages];
    return self;
}


-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([NSStringFromClass([self class]) hasPrefix:@"_"] || [self isKindOfClass:NSClassFromString(@"UITextInputController")] || [NSStringFromClass([self class]) hasPrefix:@"UIKeyboard"] || [methodName isEqualToString:@"dealloc"]) {
        
        return nil;
    }
    JKCrashProtect *protect = [JKCrashProtect new];
    protect.crashMessages =[NSString stringWithFormat:@"JKCrashProtect: [%@ %p %@]: unrecognized selector sent to instance",NSStringFromClass([self class]),self,NSStringFromSelector(aSelector)];
    class_addMethod([JKCrashProtect class], aSelector, [protect methodForSelector:@selector(JKCrashProtectCollectCrashMessages)], "v@:");
    return protect;
}



//- (void)forwardInvocation:(NSInvocation *)anInvocation{
////    NSMethodSignature *signature = [JKCrashProtect instanceMethodSignatureForSelector:@selector(JKCrashProtectCollectCrashMessages:)];
////    NSInvocation *invoker = [NSInvocation invocationWithMethodSignature:signature];
////    [invoker setTarget:[JKCrashProtect new]];
////    SEL selector = [anInvocation selector];
////    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect: [%@ %p %@]: unrecognized selector sent to instance",NSStringFromClass([self class]),self,NSStringFromSelector(selector)];
////    [invoker setArgument:&crashMessages atIndex:1];
////    [invoker invoke];
//}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSString *methodName =NSStringFromSelector(aSelector);
//    NSMethodSignature *originSignature = [JKCrashProtect instanceMethodSignatureForSelector:aSelector];
//    if ([methodName hasPrefix:@"_"]) {
//        return nil;
//    }
//
//    
//    
//    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect: [%@ %p %@]: unrecognized selector sent to instance",NSStringFromClass([self class]),self,NSStringFromSelector(aSelector)];
//    NSMethodSignature *signature = [JKCrashProtect instanceMethodSignatureForSelector:@selector(JKCrashProtectCollectCrashMessages:)];
//    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
//    return signature;
//   
//    
//    
// }





@end
