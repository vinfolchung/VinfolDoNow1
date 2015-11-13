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
#import "HomeViewController.h"
#import "UserInfoModel.h"
#import "DBBusinessManager.h"

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self isAutoLogin];
    [self isRememberPassword];
}

#pragma mark - LoginViewDelegate
- (void)presentRegistView
{
    [self presentViewController:self.registViewController animated:YES completion:^{}];
}

//登录按钮点击事件
- (void)presentHomeView
{
    //判断userInfo表中是否有对应的账号密码
    NSArray *userArr = [[DBBusinessManager sharedDBBusinessManager] getDataFromUserInfo];
    NSString *userText = self.loginView.userTextField.text;
    NSString *password = self.loginView.passTextField.text;
    NSInteger index = 0;//查找有没对应的账号 若没有变化则是没有对应的账号
    for (NSInteger i = 0; i < [userArr count]; i++) {
        UserInfoModel *userModel = userArr[i];
        if ([userText isEqualToString:userModel.phone]) {
            index++;
            if ([password isEqualToString:userModel.password]) {
                [self presentViewController:self.homeViewController animated:YES completion:nil];
                //记录账号的登录状态
                [[DBBusinessManager sharedDBBusinessManager] updateLoginWithPhone:userText login:@"YES"];
            }
            else {
                [self addLabelWithTitle:@"请重新输入密码！"];
            }
        }
    }
    if (index == 0) {
        [self addLabelWithTitle:@"请重新输入账号！"];
    }
}

//记住密码
- (void)rememberPassword
{
    if ([self.loginView.rememberBtn isSelected]) {
        [[DBBusinessManager sharedDBBusinessManager] updateRememberPassWithPhone:self.loginView.userTextField.text rememberPass:@"YES"];
    }
    else {
        [[DBBusinessManager sharedDBBusinessManager] updateRememberPassWithPhone:self.loginView.userTextField.text rememberPass:@"NO"];
    }
}

//自动登录按钮
- (void)autoLogin
{
    if ([self.loginView.autoLoginBtn isSelected]) {
        [[DBBusinessManager sharedDBBusinessManager] updateAutoLoginWithPhone:self.loginView.userTextField.text autoLogin:@"YES"];
    }
    else {
        [[DBBusinessManager sharedDBBusinessManager] updateAutoLoginWithPhone:self.loginView.userTextField.text autoLogin:@"NO"];
    }
}

#pragma mark - RegistViewControllerDelegate
- (void)registerSuccess
{
    [self addLabelWithTitle:@"注册成功！"];
}

#pragma mark - private methods
- (void)addLabelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 400*kAdaptPixel, 300*kAdaptPixel, 50*kAdaptPixel)];
    label.centerX = kScreen_Width/2;
    label.text = title;
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20.0*kAdaptPixel];
    [UIView animateWithDuration:3.0 animations:^{
        [label setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:5.0 animations:^{
            [label setAlpha:0];
        } completion:nil];
    }];
    [self.view addSubview:label];
}

//记住密码
- (void)isRememberPassword
{
    NSArray *userArr = [[DBBusinessManager sharedDBBusinessManager] getDataFromUserInfo];
    for (NSInteger i = 0; i<userArr.count; i++) {
        UserInfoModel *userModel = userArr[i];
        if ([userModel.rememberPass isEqualToString:@"YES"]) {
            [self.loginView.userTextField setText:userModel.phone];
            [self.loginView.passTextField setText:userModel.password];
            [self.loginView.rememberBtn setSelected:YES];
            [self.loginView.rememberBtn setBackgroundColor:[UIColor greenColor]];
            break;
        }
    }
}

//自动登录
- (void)isAutoLogin
{
    NSArray *userArr = [[DBBusinessManager sharedDBBusinessManager] getDataFromUserInfo];
    for (NSInteger i = 0; i<userArr.count; i++) {
        UserInfoModel *userModel = userArr[i];
        if ([userModel.login isEqualToString:@"YES"]) {
            if ([userModel.autoLogin isEqualToString:@"YES"]) {
                NSLog(@"%@,%@",userModel.login,userModel.autoLogin);
                //直接跳过登录
                [self presentViewController:self.homeViewController animated:YES completion:nil];
                break;
            }
        }
    }
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
