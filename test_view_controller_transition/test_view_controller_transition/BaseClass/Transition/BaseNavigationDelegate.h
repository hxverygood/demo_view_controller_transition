//
//  BaseNavigationDelegate.h
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationDelegate : NSObject<UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, copy) UIPercentDrivenInteractiveTransition *interactionController;

@end

NS_ASSUME_NONNULL_END
