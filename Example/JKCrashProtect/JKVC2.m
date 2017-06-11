//
//  JKVC2.m
//  JKCrashProtect
//
//  Created by Jack on 2017/6/3.
//  Copyright © 2017年 HHL110120. All rights reserved.
//

#import "JKVC2.h"

#import "JKPerson.h"


@interface JKVC2 ()
{
    JKPerson *_jack;
}
@end

@implementation JKVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _jack = [JKPerson new];
 [_jack addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//      [_jack addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//    });
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(0, 0, 80, 30);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"Click" forState:UIControlStateNormal];
    [button addTarget: self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"height changed!!!");
    }
    
}


- (void)buttonClicked:(UIButton *)button{

_jack.name = @"Jack";

}


- (void)dealloc{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
          [_jack removeObserver:self forKeyPath:@"name"];
        //[_jack removeObserver:self forKeyPath:@"name" context:nil];
    });
    [_jack removeObserver:self forKeyPath:@"name"];

//    [_jack removeObserver:self forKeyPath:@"name" context:nil];

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
