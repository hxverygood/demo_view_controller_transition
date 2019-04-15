//
//  SlideAnimationController.h
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseTransitionConst.h"


NS_ASSUME_NONNULL_BEGIN

@interface SlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGFloat transitionDuration;

- (instancetype)initWithTransitionType:(TransitionType)transitionType;

@end

NS_ASSUME_NONNULL_END
