//
//  HXPopViewController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "HXPopViewController.h"
#import "SlideAnimationController.h"


@interface HXPopViewController ()

@property (weak, nonatomic) IBOutlet UIButton *popButton;

@end



@implementation HXPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"第2个界面";
//    [self setupView];
    [_popButton addTarget:self action:@selector(popButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setupView {
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (IBAction)popButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
