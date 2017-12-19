//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/14.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "ViewController.h"
#import "BaseAnimationVC.h"
#import "KeyFrameAnimationVC.h"
#import "GroupAnimationVC.h"
#import "TransitionAnimationVC.h"
#import "AffineTransformVC.h"
#import "ComprehensiveVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, copy) NSArray *sourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Home";
    
    _sourceArray = [[NSArray alloc] initWithObjects:@{@"title":@"基础动画",@"className":@"BaseAnimationVC"}, @{@"title":@"关键帧动画",@"className":@"KeyFrameAnimationVC"},@{@"title":@"组动画",@"className":@"GroupAnimationVC"},@{@"title":@"过渡动画",@"className":@"TransitionAnimationVC"},@{@"title":@"仿射变换",@"className":@"AffineTransformVC"},@{@"title":@"综合案例",@"className":@"ComprehensiveVC"},nil];
    
    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    [self.view addSubview:_homeTableView];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"homeCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dic = self.sourceArray[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.sourceArray[indexPath.row];
    [self.navigationController pushViewController:(UIViewController *)[[NSClassFromString(dic[@"className"]) alloc] init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
