//
//  JKVC3.m
//  JKCrashProtect
//
//  Created by Jack on 2017/8/5.
//  Copyright © 2017年 HHL110120. All rights reserved.
//

#import "JKVC3.h"
#import <JKCrashProtect/NSNotificationCenter+JKCrashPtotect.h>
@interface JKVC3 ()

@end

@implementation JKVC3

-(id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printLog:) name:@"printLog" object:nil];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginBtn.frame = CGRectMake(0, 0, 60, 30);
    loginBtn.center =self.view.center;
    [loginBtn setTitle:@"click" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [[NSThread mainThread] setName:@"MainThread"];
    NSLog(@"thread name000 %@",[NSThread currentThread].name);
    
}

- (void)clicked{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [[NSThread currentThread] setName:@"childthread"];
        NSLog(@"thread name111 %@",[NSThread currentThread].name);
       // NSNotification *notif = [[NSNotification alloc] initWithName:@"printLog" object:nil userInfo:nil];
        //[[NSNotificationCenter defaultCenter] postNotification:notif handleThread:nil];
        //[[NSNotificationCenter defaultCenter]  postNotificationName:@"printLog" object:@(123) handleThread:[NSThread mainThread]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"printLog" object:@"123" userInfo:@{@"name":@"jack"} handleThread:nil];

    });

}


- (void)printLog:(NSNotification *)notification{

    NSLog(@"%@",notification);
    NSLog(@"thread name222 %@",[NSThread currentThread].name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
