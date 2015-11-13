//
//  LoginView.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate;
@interface LoginView : UIView
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *passTextField;
@property (nonatomic, strong) UIButton *rememberBtn;
@property (nonatomic, strong) UIButton *autoLoginBtn;

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end

@protocol LoginViewDelegate <NSObject>
@optional
- (void)presentRegistView;//跳转到注册页面
- (void)presentHomeView;//跳转到主页面

- (void)rememberPassword;//记住密码
- (void)autoLogin;//自动登录

@end
