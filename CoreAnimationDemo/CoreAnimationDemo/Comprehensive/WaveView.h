//
//  WaveView.h
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/15.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

//速度
@property (nonatomic, assign) CGFloat speed;
//波浪高度
@property (nonatomic, assign) CGFloat waveHeight;

- (void)wave;
- (void)stop;
@end
