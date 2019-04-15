//
//  BaseNavigationViewController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/13.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "BaseNavigationDelegate.h"


@interface BaseNavigationViewController ()

@property (nonatomic, strong) BaseNavigationDelegate *naviDelegate;

@end



@implementation BaseNavigationViewController

#pragma mark - Getter

- (BaseNavigationDelegate *)naviDelegate {
    if (!_naviDelegate) {
        _naviDelegate = [[BaseNavigationDelegate alloc] init];
    }
    return _naviDelegate;
}



#pragma mark - Initializer

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];

    if (self) {
        BaseNavigationDelegate *delegate = self.naviDelegate;
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];


}

@end
