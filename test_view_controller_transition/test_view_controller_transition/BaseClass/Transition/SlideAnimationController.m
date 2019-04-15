//
//  SlideAnimationController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "SlideAnimationController.h"



@interface SlideAnimationController ()

@property (nonatomic, assign) TransitionType transitionType;

@end



@implementation SlideAnimationController

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

    /**
     viewForKey 方法返回 nil 只有一种情况：UIModalPresentationCustom 模式下的 Modal 转场 ，通过此方法获取 presentingView 时得到的将是 nil。
     在动画控制器里，参与转场的视图只有 fromView 和 toView 之分，与转场方式无关。你可以在 fromView 和 toView 上添加任何动画。这也是动画控制器在封装后可以被第三方使用的重要原因。
     */
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
//    NSLog(@"fromView:%@", NSStringFromCGRect(fromView.frame));
//    NSLog(@"toView:%@", NSStringFromCGRect(toView.frame));

    CGFloat translation = containerView.frame.size.width;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;

    switch (_transitionType) {
        case TransitionTypePush:
        case TransitionTypePop:
        {
            translation = (_transitionType == TransitionTypePush ? translation : -translation);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0.0);
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0.0);
        }
            break;

        case TransitionTypeTabLeft:
        case TransitionTypeTabRight:
        {
            translation = (_transitionType == TransitionTypeTabLeft ? translation : -translation);
            fromViewTransform = CGAffineTransformMakeTranslation(translation, 0.0);
            toViewTransform = CGAffineTransformMakeTranslation(-translation, 0.0);
        }
            break;

        case TransitionTypePresent:
        case TransitionTypeDismiss:
        {
            translation =  containerView.frame.size.height;
            fromViewTransform = CGAffineTransformMakeTranslation(0.0, (_transitionType == TransitionTypePresent ? 0.0 : translation));
            toViewTransform = CGAffineTransformMakeTranslation(0.0, (_transitionType == TransitionTypePresent ? translation : 0.0));
        }
            break;

        default:
            break;
    }

    switch (_transitionType) {
        case TransitionTypeDismiss:
            break;

        default:
            // 1.将 toView 添加到容器视图中
            [containerView addSubview:toView];
            break;
    }

    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //考虑到转场中途可能取消的情况，转场结束后，恢复视图状态。
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;

        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

//- (void)animationEnded:(BOOL) transitionCompleted {
//
//}

@end
