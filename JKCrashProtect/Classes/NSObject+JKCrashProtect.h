//
//  NSObject+JKCrashProtect.h
//  Pods
//
//  Created by Jack on 17/4/28.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JKCrashProtect)

+ (void)JKCrashProtectswizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector withClass:(Class)targetClass;

@end
