//
//  UIViewController+JKCrashProtect.m
//  Pods
//
//  Created by Jack on 2017/6/4.
//
//

#import "UIViewController+JKCrashProtect.h"
#import <objc/runtime.h>
#import <pthread/pthread.h>

@implementation UIViewController (JKCrashProtect)

static char KVOHashTableKey;


- (void)setKVOHashTable:(NSHashTable *)KVOHasTable{
    objc_setAssociatedObject(self, &KVOHashTableKey, KVOHasTable, OBJC_ASSOCIATION_RETAIN);
}


- (NSHashTable *)KVOHashTable{
    
    return objc_getAssociatedObject(self, &KVOHashTableKey);
    
}


    

    





@end
