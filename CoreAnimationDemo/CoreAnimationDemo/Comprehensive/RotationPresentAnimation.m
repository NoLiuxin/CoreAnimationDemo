//
//  RotationPresentAnimation.m
//  CoreAnimationDemo
//
//  Created by 刘新 on 2017/12/16.
//  Copyright © 2017年 Liuxin. All rights reserved.
//

#import "RotationPresentAnimation.h"
#import "UIView+MotionBlur.h"
#import "CustomTransitionVC.h"
#import "CustomTransitionToVC.h"
#import "DemoCell.h"

@implementation RotationPresentAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取两个VC 和 动画发生的容器
    CustomTransitionVC *fromVC = (CustomTransitionVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CustomTransitionToVC *toVC   = (CustomTransitionToVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取转场发生的容器
    UIView *containerView = [transitionContext containerView];
    
    //对Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    DemoCell *cell =(DemoCell *)[fromVC.demoCollectionView cellForItemAtIndexPath:[[fromVC.demoCollectionView indexPathsForSelectedItems] firstObject]];
    fromVC.indexPath = [[fromVC.demoCollectionView indexPathsForSelectedItems]firstObject];
    
    UIView * snapShotView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = fromVC.finalCellRect = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    cell.imageView.hidden = YES;
    
    //设置第二个控制器的位置、透明度
    //得到toVC完全呈现后的frame
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageViewForSecond.hidden = YES;
    
    //把动画前后的两个ViewController加到容器中,顺序很重要,snapShotView在上方
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新；
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.imageViewForSecond.frame fromView:toVC.imageViewForSecond.superview];
    } completion:^(BOOL finished) {
        //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
        toVC.imageViewForSecond.hidden = NO;
        cell.imageView.hidden = NO;
        [snapShotView removeFromSuperview];
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
