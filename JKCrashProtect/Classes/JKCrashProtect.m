//
//  JKCrashProtect.m
//  Pods
//
//  Created by Jack on 17/4/28.
//
//

#import "JKCrashProtect.h"
//#import "JKUBSAspects.h"
#import "UIViewController+JKCrashProtect.h"

@implementation JKCrashProtect

+ (void)registerJKCrashProtect{

    
    [self configKVOCrashProtect];
}


+ (void)configKVOCrashProtect{

//    [NSObject aspect_hookSelector:@selector(addObserver:forKeyPath:options:context:) withOptions:JKUBSAspectPositionBefore usingBlock:^(id<JKUBSAspectInfo> data){
//        NSLog(@"arguments  %@",[data arguments]);
//        //data = nil;
//    } error:nil];
//    
//    [NSObject aspect_hookSelector:@selector(removeObserver:forKeyPath:context:) withOptions:JKUBSAspectPositionBefore usingBlock:^(id<JKUBSAspectInfo> data){
//    
//    } error:nil];
//    
//    SEL deallocSEL = NSSelectorFromString(@"dealloc");
//    [UIViewController aspect_hookSelector:deallocSEL withOptions:JKUBSAspectPositionBefore usingBlock:^(id<JKUBSAspectInfo> data){
//    
//    } error:nil];

    
}




- (void)JKCrashProtectCollectCrashMessages{

   NSLog(@"%@",_crashMessages);
   
}






@end
