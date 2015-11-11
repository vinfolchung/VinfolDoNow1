//
//  LoginView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "LoginView.h"
#import "GestureManager.h"
#define userTextField_x (200*kAdaptPixel)

@interface LoginView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *passTextField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation LoginView
#pragma mark - life cycle
- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self) {
        [self addSubview:self.bgImageView];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.userTextField];
        [self addSubview:self.passTextField];
        [self addSubview:self.loginBtn];
        [self addSubview:self.registBtn];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userTextField) {
        [self.passTextField becomeFirstResponder];
    }
    else {
        [self.passTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - event respond

- (void)regisBtnOnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(presentRegistView)]) {
        [self.delegate presentRegistView];
    }
}

- (void)loginBtnOnClicked:(id)sender
{
    [self.passTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(presentHomeView)]) {
        [self.delegate presentHomeView];
    }
}

#pragma mark - private methods
- (UITextField *)createTextFieldWithTitle:(NSString *)title
{
    CGFloat textFieldY;
    if ([title isEqualToString:@"手机号"]) {
        textFieldY = userTextField_x;
    }else {
        textFieldY = userTextField_x + 50*kAdaptPixel;
    }
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40*kAdaptPixel, textFieldY, kScreen_Width - 2*40*kAdaptPixel, 40*kAdaptPixel)];
    textField.placeholder = title;
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.alpha = 0.8f;
    textField.delegate = self;
    return textField;
}


#pragma mark - getter and setter
- (UITextField *)userTextField
{
    if (!_userTextField) {
        _userTextField = [self createTextFieldWithTitle:@"手机号"];
    }
    return _userTextField;
}

- (UITextField *)passTextField
{
    if (!_passTextField) {
        _passTextField = [self createTextFieldWithTitle:@"密码"];
        _passTextField.secureTextEntry = YES;
    }
    return _passTextField;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(80*kAdaptPixel, userTextField_x + 100*kAdaptPixel, kScreen_Width - 2*80*kAdaptPixel, 50*kAdaptPixel)];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 10.0f;
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20.0*kAdaptPixel];
        _loginBtn.alpha = 0.8f;
        _loginBtn.backgroundColor = [UIColor whiteColor];
        _loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_loginBtn addTarget:self action:@selector(loginBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registBtn
{
    if (!_registBtn) {
        _registBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*kAdaptPixel, kScreen_Height - 40*kAdaptPixel, 80*kAdaptPixel, 20*kAdaptPixel)];
        [_registBtn setTitle:@"注册用户" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kAdaptPixel];
        [_registBtn addTarget:self action:@selector(regisBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        _bgImageView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    }
    return _bgImageView;
}


@end
