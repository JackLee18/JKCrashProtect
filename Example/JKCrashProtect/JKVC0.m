//
//  JKVC0.m
//  JKCrashProtect
//
//  Created by Jack on 17/4/28.
//  Copyright © 2017年 HHL110120. All rights reserved.
//

#import "JKVC0.h"

@interface JKVC0 ()

@end

@implementation JKVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 0, 200, 30);
    button1.center = CGPointMake(self.view.center.x, self.view.center.y+50) ;
    
    [button1 setTitle:@"click事件" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(JKClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JKTapped)];
    [self.view addGestureRecognizer:tap];


}

//- (void)JKClicked{
//
//    NSLog(@"JKClicked");
//}

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
