//
//  JKViewController.m
//  JKCrashProtect
//
//  Created by HHL110120 on 04/28/2017.
//  Copyright (c) 2017 HHL110120. All rights reserved.
//

#import "JKViewController.h"

@interface JKViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_contentTable;
    NSArray *_dataArray;
}

@end

@implementation JKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = @[@"unrecognized selector sent to instance",@"KVC产生的crash",@"KVO产生的crash",@"Notification产生的crash"];
    
    _contentTable = [[UITableView alloc] initWithFrame:self.view.frame];
    [_contentTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    _contentTable.dataSource = self;
    _contentTable.delegate = self;
    [self.view addSubview:_contentTable];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = [NSString stringWithFormat:@"JKVC%d",(int)indexPath.row];
    Class vcClassName = NSClassFromString(vcName);
    UIViewController *vc = (UIViewController *)[vcClassName new];
    vc.title = _dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
