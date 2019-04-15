//
//  BaseViewController.h
//
//  Created by hans on 2017/8/10.
//  Copyright © 2017年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL navbarIsTranslucent;
@property (nonatomic, assign) BOOL navbarIsDark;
/**
   是否从屏幕左边缘右滑返回上一级页面。
   如果是自定义 transition，则最好打开这个开关；
   默认是打开状态
 */
@property (nonatomic, assign) BOOL canEdgePanGesturBack;

@end
