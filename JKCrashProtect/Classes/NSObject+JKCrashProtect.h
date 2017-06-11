//
//  NSObject+JKCrashProtect.h
//  Pods
//
//  Created by Jack on 17/4/28.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JKCrashProtect)

@property (nonatomic,strong) NSHashTable *KVOHashTable;


+ (void)JKCrashProtectswizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector withClass:(Class)targetClass;

@end
