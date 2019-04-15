//
//  ViewController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "ViewController.h"
#import "HXPopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";
}

- (IBAction)pushButtonAction:(id)sender {
    HXPopViewController *vc = [[HXPopViewController alloc] init];
    vc.navbarIsTranslucent = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
