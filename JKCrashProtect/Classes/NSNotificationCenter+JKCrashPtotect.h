//
//  NSNotificationCenter+JKCrashPtotect.h
//  Pods
//
//  Created by Jack on 2017/8/5.
//
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (JKCrashPtotect)

- (void)postNotification:(nonnull NSNotification *)notification handleThread:(nullable NSThread *)thread;

- (void)postNotificationName:(nonnull NSNotificationName)aName object:(nullable id)anObject handleThread:(nullable NSThread *)thread;

- (void)postNotificationName:(nonnull NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo handleThread:(nullable NSThread *)thread;


@end
