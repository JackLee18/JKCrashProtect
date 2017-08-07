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

@property (nonatomic,assign) BOOL isAspected;


+ (void)JKCrashProtectswizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector withClass:(Class)targetClass;

- (id)JKCrashProtectperformSelector:(SEL)aSelector withObjects:(NSArray *)objects;
@end
