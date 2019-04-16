//
//  PresentedViewController.m
//  test_view_controller_transition
//
//  Created by shandiangou on 2019/4/16.
//  Copyright © 2019 lightingdog. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation PresentedViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _closeButton.alpha = 0.0;

    NSLayoutConstraint *widthConstraint = nil;
    for (NSLayoutConstraint *constraint in _textField.constraints) {
        if ([constraint.identifier isEqualToString:@"Width"]) {
            widthConstraint = constraint;
            break;
        }
    }
    widthConstraint.constant = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLayoutConstraint *widthConstraint = nil;
    for (NSLayoutConstraint *constraint in _textField.constraints) {
        if ([constraint.identifier isEqualToString:@"Width"]) {
            widthConstraint = constraint;
            break;
        }
    }
    widthConstraint.constant = self.view.frame.size.width * 2 / 3;

    [UIView animateWithDuration:0.3 animations:^{
        self.closeButton.alpha = 1.0;
        [self.view layoutIfNeeded];
    }];
}



#pragma mark - Action

- (IBAction)closeButtonAction:(id)sender {
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
    transform = CGAffineTransformScale(transform, 0.1, 0.1);

    NSLayoutConstraint *widthConstraint = nil;
    for (NSLayoutConstraint *constraint in _textField.constraints) {
        if ([constraint.identifier isEqualToString:@"Width"]) {
            widthConstraint = constraint;
            break;
        }
    }
    widthConstraint.constant = 0.0;

    [UIView animateWithDuration:0.4 animations:^{
        self.closeButton.transform = transform;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}


@end
