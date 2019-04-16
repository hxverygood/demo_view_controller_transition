//
//  BaseViewController.m
//
//  Created by hans on 2017/8/10.
//  Copyright © 2017年. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationDelegate.h"

#define NAVBAR_BACKGROUND_COLOR     [UIColor whiteColor]

static CGFloat naviFontSize = 18.0;



@interface BaseViewController ()

@property (nonatomic, assign) BOOL navbarIsTrans;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanGesture;
@property (nonatomic, strong) BaseNavigationDelegate *navigationDelegate;

@end



@implementation BaseViewController


#pragma mark - UI

- (void)dealloc {
    [_edgePanGesture removeTarget:self action:@selector(handleEdgePanGesture:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self base_setupView];
    [self adapterForIOSVersion];
    [self changeNavigationBar];
    [self hideNavigationBarShadowImage:YES];
//    [self.view layoutIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navbarIsTrans = _navbarIsTranslucent;
    _canEdgePanGesturBack = YES;

}



#pragma mark - Private Func

- (void)base_setupView {
    /**
        配置view的尺寸
     */
    CGFloat y = 0.0;
    CGFloat viewWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    if (self.navigationController.navigationBar.hidden == NO) {
        viewHeight -= (64.0 + isIPhoneXSeries_Top_Offset());
        y = 64.0 + isIPhoneXSeries_Top_Offset();
    }

    // 判断 tabbar 是否显示
    if (self.tabBarController != nil &&
        self.tabBarController.tabBar.isHidden == NO) {
        viewHeight -= 49.0;
    }

    self.view.frame = CGRectMake(0.0, y, viewWidth, viewHeight);


    // 屏幕边缘右滑返回
    if (_canEdgePanGesturBack) {
        _edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] init];
        _edgePanGesture.edges = UIRectEdgeLeft;
        [_edgePanGesture addTarget:self action:@selector(handleEdgePanGesture:)];
        [self.view addGestureRecognizer:_edgePanGesture];
    }
}

- (void)changeNavigationBar {
    
    if (_navbarIsDark) {
        self.navigationController.navigationBar.hidden = NO;
        
        // 状态栏样式
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

        // navbar title的颜色
        self.navigationController.navigationBar.titleTextAttributes = \
        @{NSFontAttributeName:[UIFont systemFontOfSize:naviFontSize],
          NSForegroundColorAttributeName:[UIColor whiteColor]};
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:38/255.0 green:41/255.0 blue:48/255.0 alpha:1.0];
        
        return;
    }
    
    if (_navbarIsTrans) {
        self.navigationController.navigationBar.hidden = NO;

        // 状态栏样式
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        
        self.navigationController.navigationBar.translucent = YES;
         self.navigationController.edgesForExtendedLayout = UIRectEdgeTop;
        // 导航栏背景透明
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        // navbar背景颜色
        self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
        // navbar title的颜色
        self.navigationController.navigationBar.titleTextAttributes = \
        @{NSFontAttributeName:[UIFont systemFontOfSize:naviFontSize],
          NSForegroundColorAttributeName:[UIColor whiteColor]};
    }
    else {
        self.navigationController.navigationBar.hidden = NO;

        // 状态栏样式
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        //[self backBarButtonItemWithImageName:@""];
        self.navigationController.navigationBar.hidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.edgesForExtendedLayout = UIRectEdgeTop;
        // navbar背景颜色
        self.navigationController.navigationBar.barTintColor = NAVBAR_BACKGROUND_COLOR;
        // navbar title的颜色
        self.navigationController.navigationBar.titleTextAttributes = \
        @{NSFontAttributeName:[UIFont systemFontOfSize:naviFontSize],
          NSForegroundColorAttributeName:[UIColor blackColor]};
    }
}

/// 对不同的iOS版本进行适配
- (void)adapterForIOSVersion {
    if (@available(iOS 11.0, *)) {
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/// 是否隐藏导航栏下的分隔线
- (void)hideNavigationBarShadowImage:(BOOL)hide {
    if (self.navigationController.navigationBar.translucent) {
        if (self.navigationController.navigationBar.subviews.count > 0 &&
            self.navigationController.navigationBar.subviews[0].subviews.count > 1) {
            self.navigationController.navigationBar.subviews[0].subviews[1].hidden = hide;
        }
    } else {
        if (self.navigationController.navigationBar.subviews.count > 0 &&
            self.navigationController.navigationBar.subviews[0].subviews.count > 0) {
            self.navigationController.navigationBar.subviews[0].subviews[0].hidden = hide;
        }
    }
}



#pragma mark 判断是否是 iPhoneX 系列手机

static inline BOOL isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }

    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }

    return iPhoneXSeries;
}

static inline CGFloat isIPhoneXSeries_Top_Offset() {
    return isIPhoneXSeries() ? 24.0 : 0.0;
}
static inline CGFloat isIPhoneXSeries_Bottom_Offset() {
    return isIPhoneXSeries() ? 34.0 : 0.0;
}



#pragma mark - Action

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gr {
    CGFloat translationX = [gr translationInView:self.view].x;
    CGFloat velocityX = [gr velocityInView:self.view].x;

    CGFloat translationBase = self.view.frame.size.width;
    CGFloat translationAbs =  translationX > 0 ? translationX : -translationX;
    CGFloat percent = MIN(translationAbs / translationBase, 1.0);

    switch (gr.state) {
        case UIGestureRecognizerStateBegan:
        {
            _navigationDelegate = (BaseNavigationDelegate *)self.navigationController.delegate;
            _navigationDelegate.interactive = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;

        case UIGestureRecognizerStateChanged:
        {
            [_navigationDelegate.interactionController updateInteractiveTransition:percent];
        }
            break;

        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (velocityX >= 0.0 && percent > 0.3) {
                [_navigationDelegate.interactionController finishInteractiveTransition];
            }
            else {
                [_navigationDelegate.interactionController cancelInteractiveTransition];
            }
            _navigationDelegate.interactive = NO;
        }
            break;

        default:
            break;
    }
}



#pragma mark - 内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
