//
//  BaseModalTransitionDelegate.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/16.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "BaseModalTransitionDelegate.h"
#import "BaseModalAnimationController.h"
#import "BaseModalPresentationController.h"


@implementation BaseModalTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    BaseModalAnimationController *animator = [[BaseModalAnimationController alloc] init];
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    BaseModalAnimationController *animator = [[BaseModalAnimationController alloc] init];
    return animator;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    BaseModalPresentationController *presentation = [[BaseModalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentation;
}

@end
