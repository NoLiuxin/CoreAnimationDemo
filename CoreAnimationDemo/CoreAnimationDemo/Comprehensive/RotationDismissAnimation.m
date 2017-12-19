//
//  RotationDismissAnimation.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/16.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "RotationDismissAnimation.h"
#import "UIView+MotionBlur.h"
#import "CustomTransitionVC.h"
#import "CustomTransitionToVC.h"
#import "DemoCell.h"

@implementation RotationDismissAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //获取动画前后两个VC 和 发生的容器containerView
    CustomTransitionVC *toVC = (CustomTransitionVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CustomTransitionToVC *fromVC = (CustomTransitionToVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    //在前一个VC上创建一个截图
    UIView  *snapShotView = [fromVC.imageViewForSecond snapshotViewAfterScreenUpdates:NO];
    snapShotView.backgroundColor = [UIColor clearColor];
    snapShotView.frame = [containerView convertRect:fromVC.imageViewForSecond.frame fromView:fromVC.imageViewForSecond.superview];
    fromVC.imageViewForSecond.hidden = YES;
    
    //初始化后一个VC的位置
    //得到toVC完全呈现后的frame
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    //获取toVC中图片的位置
    DemoCell *cell = (DemoCell *)[toVC.demoCollectionView cellForItemAtIndexPath:toVC.indexPath];
    cell.imageView.hidden = YES;
    //    CGRect finalRect =  [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    
    
    //顺序很重要，
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    //发生动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        snapShotView.frame = toVC.finalCellRect;
    } completion:^(BOOL finished) {
        [snapShotView removeFromSuperview];
        fromVC.imageViewForSecond.hidden = NO;
        cell.imageView.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}
@end
