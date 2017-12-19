//
//  WaveAnimationVC.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/15.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "WaveAnimationVC.h"
#import "WaveView.h"

@interface WaveAnimationVC ()
@property (weak, nonatomic) IBOutlet WaveView *waveView;

@end

@implementation WaveAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"波浪效果";
    
    self.waveView.speed = 2;
    self.waveView.waveHeight = 10;
}
- (IBAction)start:(id)sender {
    [self.waveView wave];
}
- (IBAction)stop:(id)sender {
    [self.waveView stop];
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
