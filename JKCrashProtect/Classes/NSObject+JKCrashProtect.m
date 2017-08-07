//
//  NSObject+JKCrashProtect.m
//  Pods
//
//  Created by Jack on 17/4/28.
//
//

#import "NSObject+JKCrashProtect.h"
#import <JKCrashProtect/JKCrashProtectHandler.h>
#import <objc/runtime.h>

@implementation NSObject (JKCrashProtect)

static char KVOHashTableKey;
static char isAspectedKey;


+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       
      [self JKCrashProtectswizzleMethod:@selector(addObserver:forKeyPath:options:context:) withMethod:@selector(JKCrashProtectaddObserver:forKeyPath:options:context:) withClass:[NSObject class]];
        
        [self JKCrashProtectswizzleMethod:@selector(removeObserver:forKeyPath:) withMethod:@selector(JKCrashProtectremoveObserver:forKeyPath:) withClass:[NSObject class]];
        
    });
 
    
}

#pragma mark --- KVCCrashProtect
-(void)setNilValueForKey:(NSString *)key{
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'NSInvalidArgumentException', reason: '[%@ %p setNilValueForKey]: could not set nil as the value for the key %@.'",NSStringFromClass([self class]),self,key];
    JKCrashProtectHandler *protectHandler = [JKCrashProtectHandler new];
    protectHandler.crashMessages =crashMessages;
    [protectHandler JKCrashProtectCollectCrashMessages];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'NSUnknownKeyException', reason: '[%@ %p setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key: %@,value:%@'",NSStringFromClass([self class]),self,key,value];
    JKCrashProtectHandler *protectHandler = [JKCrashProtectHandler new];
    protectHandler.crashMessages =crashMessages;
    [protectHandler JKCrashProtectCollectCrashMessages];
}

- (nullable id)valueForUndefinedKey:(NSString *)key{

    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect:'Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[%@ %p valueForUndefinedKey:]: this class is not key value coding-compliant for the key: %@",NSStringFromClass([self class]),self,key];
    JKCrashProtectHandler *protectHandler = [JKCrashProtectHandler new];
    protectHandler.crashMessages =crashMessages;
    [protectHandler JKCrashProtectCollectCrashMessages];
    return self;
}


#pragma mark --- unrecognized selector sent to instance


#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wobjc-protocol-method-implementation"

-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([NSStringFromClass([self class]) hasPrefix:@"_"] || [self isKindOfClass:NSClassFromString(@"UITextInputController")] || [NSStringFromClass([self class]) hasPrefix:@"UIKeyboard"] || [methodName isEqualToString:@"dealloc"]) {
        
        return nil;
    }
    if (self.isAspected) {
        return self;

    }
    JKCrashProtectHandler *protectHandler = [JKCrashProtectHandler new];
    protectHandler.crashMessages =[NSString stringWithFormat:@"JKCrashProtect: [%@ %p %@]: unrecognized selector sent to instance",NSStringFromClass([self class]),self,NSStringFromSelector(aSelector)];
    class_addMethod([JKCrashProtectHandler class], aSelector, [protectHandler methodForSelector:@selector(JKCrashProtectCollectCrashMessages)], "v@:");
    return protectHandler;
}

#pragma clang diagnostic pop

#pragma mark --- KVOCrashProtect

- (void)setKVOHashTable:(NSHashTable *)KVOHasTable{
    objc_setAssociatedObject(self, &KVOHashTableKey, KVOHasTable, OBJC_ASSOCIATION_RETAIN);
}


- (NSHashTable *)KVOHashTable{
    
    return objc_getAssociatedObject(self, &KVOHashTableKey);
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wint-conversion"
- (void)setIsAspected:(BOOL)isAspected{
    objc_setAssociatedObject(self, &isAspectedKey, @(isAspected), OBJC_ASSOCIATION_ASSIGN);
}

#pragma clang diagnostic pop

- (BOOL)isAspected{
    
    return [objc_getAssociatedObject(self, &isAspectedKey) boolValue];
    
}


- (void)JKCrashProtectaddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    if ([observer isKindOfClass:[UIViewController class]]) {
        
        @synchronized (self) {
            NSInteger kvoHash = [self _JKCrashProtectHash:observer :keyPath];

        
            if (!self.KVOHashTable) {
                self.KVOHashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
            }
        
        if (![self.KVOHashTable containsObject:@(kvoHash)]) {
            [self.KVOHashTable addObject:@(kvoHash)];
            [self JKCrashProtectaddObserver:observer forKeyPath:keyPath options:options context:context];
        }
        
    }
        
    }else{
    
        [self JKCrashProtectaddObserver:observer forKeyPath:keyPath options:options context:context];
        
    }
    
}


- (void)JKCrashProtectremoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{

    if ([observer isKindOfClass:[UIViewController class]]) {
        
        @synchronized (self) {
       
            if (!observer) {
                return;
            }
            NSInteger kvoHash = [self _JKCrashProtectHash:observer :keyPath];
            NSHashTable *hashTable = [self KVOHashTable];
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

- (id)JKCrashProtectperformSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    
    for (id object in objects) {
        id tempObject = object;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}






@end
