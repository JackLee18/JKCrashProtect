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

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       
      [self JKCrashProtectswizzleMethod:@selector(addObserver:forKeyPath:options:context:) withMethod:@selector(JKCrashProtectaddObserver:forKeyPath:options:context:) withClass:[NSObject class]];
        
        [self JKCrashProtectswizzleMethod:@selector(removeObserver:forKeyPath:context:) withMethod:@selector(JKCrashProtectremoveObserver:forKeyPath:context:) withClass:[NSObject class]];
        [self JKCrashProtectswizzleMethod:@selector(removeObserver:forKeyPath:) withMethod:@selector(JKCrashProtectremoveObserver:forKeyPath:) withClass:[NSObject class]];
        
    });
 
    
}

#pragma mark --- KVCCrashProtect
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


#pragma mark --- unrecognized selector sent to instance

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

#pragma mark --- KVOCrashProtect

- (void)JKCrashProtectaddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    if ([observer isKindOfClass:[UIViewController class]]) {
        
        @synchronized (self) {
            NSInteger kvoHash = [self _JKCrashProtectHash:observer :keyPath];
             UIViewController *currentVC = (UIViewController *)observer;
        
            if (!currentVC.KVOHashTable) {
                currentVC.KVOHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
            }
        
        if (![currentVC.KVOHashTable containsObject:@(kvoHash)]) {
            [currentVC.KVOHashTable addObject:@(kvoHash)];
            [self JKCrashProtectaddObserver:observer forKeyPath:keyPath options:options context:context];
        }
        
    }
        
    }else{
    
        [self JKCrashProtectaddObserver:observer forKeyPath:keyPath options:options context:context];
        
    }
    
}


//- (void)JKCrashProtectremoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context{
//    
//    if ([observer isKindOfClass:[UIViewController class]]) {
//        NSInteger kvoHash = [self _JKCrashProtectHash:observer :keyPath];
//        UIViewController *currentVC = (UIViewController *)observer;
//        NSLock *lock =[[NSLock  alloc]init];
//        [lock tryLock];
//        if (!currentVC.KVOHashTable) {
//            currentVC.KVOHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
//        }
//        if ([currentVC.KVOHashTable containsObject:@(kvoHash)]) {
//            [currentVC.KVOHashTable removeObject:@(kvoHash)];
//            [self JKCrashProtectremoveObserver:observer forKeyPath:keyPath context:context];
//        }
//        [lock unlock];
//        
//    }else{
//        
//        [self JKCrashProtectremoveObserver:observer forKeyPath:keyPath context:context];
//        
//    }
//}


- (void)JKCrashProtectremoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{

    if ([observer isKindOfClass:[UIViewController class]]) {
        
        @synchronized (self) {
       
            if (!observer) {
                NSLog(@"observer不存在了");
                return;
            }
            NSInteger kvoHash = [self _JKCrashProtectHash:observer :keyPath];
            UIViewController *currentVC = (UIViewController *)observer;
            NSHashTable *hashTable = currentVC.KVOHashTable;
            if (!hashTable) {
                return;
            }
            

            
            if ([hashTable containsObject:@(kvoHash)]) {
                [hashTable removeObject:@(kvoHash)];
                [self JKCrashProtectremoveObserver:observer forKeyPath:keyPath];
            }
        }
        
        
    }else{
        
        [self JKCrashProtectremoveObserver:observer forKeyPath:keyPath];
        
    }
}



+ (void)JKCrashProtectswizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector withClass:(Class)targetClass
{
    
    
    Method originalMethod = class_getInstanceMethod(targetClass, origSelector);
    Method swizzledMethod = class_getInstanceMethod(targetClass, newSelector);
    
    if (!originalMethod) { // exchange ClassMethod
        originalMethod = class_getClassMethod(targetClass, origSelector);
        swizzledMethod = class_getClassMethod(targetClass, newSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
        return;
    }
    BOOL didAddMethod = class_addMethod(targetClass,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(targetClass,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


/**
 该方法为私有方法

 @param observer 观察者
 @param keyPath keypath
 @return 　综合的hash值
 */
- (NSInteger)_JKCrashProtectHash:(NSObject *)observer :(NSString *)keyPath{
   
    NSArray *KVOContentArr = @[observer,keyPath];
    NSInteger hash = [KVOContentArr hash];
    return hash;
}





@end
