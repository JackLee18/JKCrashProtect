//
//  JKVC1.m
//  JKCrashProtect
//
//  Created by Jack on 17/4/28.
//  Copyright © 2017年 HHL110120. All rights reserved.
//
@interface Person : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger age;

@end

@implementation Person




@end


#import "JKVC1.h"
#import "NSObject+JKCrashProtect.h"
@interface JKVC1 ()

@end

@implementation JKVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    Person *jack = [Person new];
    NSArray *obj = @[@"123"];
    NSObject *object = [NSObject new];
    //[jack setValue:nil forKey:@"age"];
    //[jack setValue:obj forKey:@"age"];
   // NSObject *obj = [NSObject new];
    [object setValue:nil forKey:@"name"];
    

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
