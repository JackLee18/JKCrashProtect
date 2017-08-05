//
//  JKCrashProtectHandler.h
//  Pods
//
//  Created by Jack on 2017/8/5.
//
//

#import <Foundation/Foundation.h>

@interface JKCrashProtectHandler : NSObject

@property (nonatomic,copy) NSString *crashMessages;

/**
 收集crash信息的方法
 这个方法需要通过category进行重写，方便在发送给后台的时候携带者更多的信息，比如机型，时间，版本号，操作系统等等信息
 @param crashMessage 收集到的crash信息
 */
- (void)JKCrashProtectCollectCrashMessages;

@end
