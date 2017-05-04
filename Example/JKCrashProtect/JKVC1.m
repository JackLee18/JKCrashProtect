//
//  JKVC1.m
//  JKCrashProtect
//
//  Created by Jack on 17/4/28.
//  Copyright © 2017年 HHL110120. All rights reserved.
//
@interface Country : NSObject
@property (nonatomic,copy)NSString *name;

@end

@implementation Country


@end

@interface Person : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)Country *country;


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
    Country *country = [Country new];
    jack.country =country;
    [jack setValue:@"111" forKeyPath:@"abc.name"];
    //[jack setValue:obj forKey:@"age"];
   // NSObject *obj = [NSObject new];
   // [object setValue:@"abc" forKey:@"123"];
    

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
