//
//  BaseNavigationDelegate.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "BaseNavigationDelegate.h"
#import "BaseTransitionConst.h"
#import "SlideAnimationController.h"

@interface BaseNavigationDelegate ()

@end


@implementation BaseNavigationDelegate

#pragma mark - Getter

- (UIPercentDrivenInteractiveTransition *)interactionController {
    if (!_interactionController) {
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _interactionController;
}



#pragma mark  -

- (instancetype)init {
    self = [super init];
    if (self) {
//        _interactive = YES;
    }
    return self;
}



#pragma mark - UINavigationController Delegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC  toViewController:(UIViewController *)toVC  {
    TransitionType type = TransitionTypeNone;

    if (operation == UINavigationControllerOperationPush) {
        type = TransitionTypePush;
    }
    else if (operation == UINavigationControllerOperationPop) {
        type = TransitionTypePop;
    }

    SlideAnimationController *animator = [[SlideAnimationController alloc] initWithTransitionType:type];
    return animator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return self.interactive ? self.interactionController : nil;
}

@end
