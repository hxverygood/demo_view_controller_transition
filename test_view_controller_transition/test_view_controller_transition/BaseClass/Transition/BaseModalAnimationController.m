//
//  BaseModalAnimationController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/16.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "BaseModalAnimationController.h"

@interface BaseModalAnimationController ()

@property (nonatomic, assign) TransitionType transitionType;

@end



@implementation BaseModalAnimationController

#pragma mark - Initializer

- (instancetype)initWithTransitionType:(TransitionType)transitionType {
    self = [super init];
    if (self) {
        self.transitionType = transitionType;
    }
    return self;
}



#pragma mark - Animated Transitioning
// 转场时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _transitionDuration > 0.0 ? _transitionDuration : 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    CGFloat duration = [self transitionDuration:transitionContext];

    if (toVC.isBeingPresented) {
        //1
        [containerView addSubview:toView];

        //设置 presentedView 和 暗背景视图 dimmingView 的初始位置和尺寸。
        CGFloat toViewWidth = containerView.frame.size.width * 2 / 3;
        CGFloat toViewHeight = containerView.frame.size.height * 2 / 3;
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, 1, toViewHeight);

        // 在 iOS 8 中，这个背景由 OverlayPresentationController 去添加
        if (@available(iOS 8, *)) {
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
        else {
            //在 presentedView 后面添加暗背景视图 dimmingView，注意两者在 containerView 中的位置。
            UIView *dimmingView = [[UIView alloc] init];
            [containerView insertSubview:dimmingView belowSubview:toView];

            dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            dimmingView.center = containerView.center;
            dimmingView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);

            //实现出现时的尺寸变化的动画
            [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
                dimmingView.bounds = containerView.bounds;
            } completion:^(BOOL finished) {
                //2
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            }];
        }
    }

    if (fromVC.isBeingDismissed) {
        //处理 Dismissal 转场，按照上一小节的结论，.Custom 模式下不要将 toView 添加到 containerView，省去了上面标记1处的操作；
        CGFloat fromViewHeight = fromView.frame.size.height;
        [UIView animateWithDuration:duration animations:^{
            fromView.bounds = CGRectMake(0, 0, 1, fromViewHeight);
        } completion:^(BOOL finished) {
            //2
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end
