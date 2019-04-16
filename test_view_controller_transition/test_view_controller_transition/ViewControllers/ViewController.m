//
//  ViewController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "ViewController.h"
#import "PopViewController.h"
#import "BaseModalTransitionDelegate.h"
#import "PresentedViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";
}

- (IBAction)pushButtonAction:(id)sender {
    PopViewController *vc = [[PopViewController alloc] init];
    vc.navbarIsTranslucent = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)presentButtonAction:(id)sender {
    BaseModalTransitionDelegate *delegate = [[BaseModalTransitionDelegate alloc] init];

    PresentedViewController *vc = [[PresentedViewController alloc] init];
    vc.transitioningDelegate = delegate;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
