//
//  UIViewController+JKCrashProtect.m
//  Pods
//
//  Created by Jack on 2017/6/4.
//
//

#import "UIViewController+JKCrashProtect.h"
#import <objc/runtime.h>
@implementation UIViewController (JKCrashProtect)

static char KVOHasTableKey;

- (NSHashTable *)KVOHasTable{

    return objc_getAssociatedObject(self, &KVOHasTableKey);
}

- (void)setKVOHasTable:(NSHashTable *)KVOHasTable{
    objc_setAssociatedObject(self, &KVOHasTableKey, KVOHasTable, OBJC_ASSOCIATION_RETAIN);
}

@end
