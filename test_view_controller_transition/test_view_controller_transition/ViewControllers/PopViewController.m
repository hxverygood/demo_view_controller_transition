//
//  PopViewController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/12.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "PopViewController.h"


@interface PopViewController ()

@property (weak, nonatomic) IBOutlet UIButton *popButton;

@end



@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"第2个界面";
    [_popButton addTarget:self action:@selector(popButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)popButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
