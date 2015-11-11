//
//  LoginView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "LoginView.h"
#import "GestureManager.h"
#define userTextField_y (200*kAdaptPixel)
#define label_y (userTextField_y + 170*kAdaptPixel)

@interface LoginView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *rememberBtn;
@property (nonatomic, strong) UIButton *autoLoginBtn;

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
        [self addLabelWtihTitle:@"记住密码"];
        [self addLabelWtihTitle:@"自动登录"];
        [self addSubview:self.rememberBtn];
        [self addSubview:self.autoLoginBtn];
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
    [self.userTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(presentRegistView)]) {
        [self.delegate presentRegistView];
    }
}

- (void)rememberBtnOnClicked:(id)sender
{
    [self.userTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    if (self.rememberBtn.selected) {
        [self.rememberBtn setSelected:NO];
        [self.rememberBtn setBackgroundColor:[UIColor clearColor]];
    }
    else {
        [self.rememberBtn setSelected:YES];
        [self.rememberBtn setBackgroundColor:[UIColor greenColor]];
    }
}

- (void)autoLoginBtnOnClicked:(id)sender
{
    [self.userTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    if (self.autoLoginBtn.selected) {
        [self.autoLoginBtn setSelected:NO];
        [self.autoLoginBtn setBackgroundColor:[UIColor clearColor]];
    }
    else {
        [self.autoLoginBtn setSelected:YES];
        [self.autoLoginBtn setBackgroundColor:[UIColor greenColor]];
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
        textFieldY = userTextField_y;
    }else {
        textFieldY = userTextField_y + 50*kAdaptPixel;
    }
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40*kAdaptPixel, textFieldY, kScreen_Width - 2*40*kAdaptPixel, 40*kAdaptPixel)];
    textField.placeholder = title;
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.alpha = 0.8f;
    textField.delegate = self;
    return textField;
}

- (void)addLabelWtihTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, label_y, 70*kAdaptPixel, 20*kAdaptPixel)];
    if ([title isEqualToString:@"记住密码"]) {
        label.x = 40*kAdaptPixel;
    }else {
        label.x = kScreen_Width - 145*kAdaptPixel;
    }
    label.text = title;
    label.font = [UIFont systemFontOfSize:16.0*kAdaptPixel];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
}

- (UIButton *)createBtnWithTag:(NSInteger)tag
{
    //tag1 左边按钮  tag2右边按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, label_y + 3*kAdaptPixel, 15*kAdaptPixel, 15*kAdaptPixel)];
    if (tag == 1) {
        btn.x = 125*kAdaptPixel;
    }else {
        btn.x = kScreen_Width - 60*kAdaptPixel;
    }
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.borderWidth = 1.5;
    btn.layer.masksToBounds = YES;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    btn.layer.borderColor = colorref;
    return btn;
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
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(80*kAdaptPixel, userTextField_y + 100*kAdaptPixel, kScreen_Width - 2*80*kAdaptPixel, 50*kAdaptPixel)];
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

- (UIButton *)rememberBtn
{
    if (!_rememberBtn) {
        _rememberBtn = [self createBtnWithTag:1];
        [_rememberBtn addTarget:self action:@selector(rememberBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rememberBtn;
}

- (UIButton *)autoLoginBtn
{
    if (!_autoLoginBtn) {
        _autoLoginBtn = [self createBtnWithTag:2];
        [_autoLoginBtn addTarget:self action:@selector(autoLoginBtnOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _autoLoginBtn;
}

@end
