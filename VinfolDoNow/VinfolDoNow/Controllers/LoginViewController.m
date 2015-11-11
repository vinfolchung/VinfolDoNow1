//
//  LoginViewController.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistViewController.h"
#import "GestureManager.h"
#import "FMDB.h"
#import "HomeViewController.h"

@interface LoginViewController ()<LoginViewDelegate,RegistViewControllerDelegate>
@property (nonatomic, strong) LoginView *loginView;
@property (nonatomic, strong) RegistViewController *registViewController;
@property (nonatomic, strong) HomeViewController *homeViewController;

@end

@implementation LoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.loginView addGestureRecognizer:[GestureManager sharedGestureManager].tapGesture];
    self.registViewController.delegate = self;
}

#pragma mark - LoginViewDelegate
- (void)presentRegistView
{
    [self presentViewController:self.registViewController animated:YES completion:^{}];
}

- (void)presentHomeView
{
    [self presentViewController:self.homeViewController animated:YES completion:nil];
}

#pragma mark - RegistViewControllerDelegate
- (void)registerSuccess
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 400*kAdaptPixel, 300*kAdaptPixel, 50*kAdaptPixel)];
    label.centerX = kScreen_Width/2;
    label.text = @"注册成功!";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20.0*kAdaptPixel];
    [UIView animateWithDuration:0.3 animations:^{
        [label setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.0 animations:^{
            [label setAlpha:0];
        } completion:nil];
    }];

    [self.view addSubview:label];
}

#pragma mark - getter and setter
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
        _loginView.delegate = self;
    }
    return _loginView;
}

- (RegistViewController *)registViewController
{
    if (!_registViewController) {
        _registViewController = [[RegistViewController alloc] init];
    }
    return _registViewController;
}

- (HomeViewController *)homeViewController
{
    if (!_homeViewController) {
        _homeViewController = [[HomeViewController alloc] init];
        _homeViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    return _homeViewController;
}

@end
