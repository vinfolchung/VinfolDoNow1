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

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end

@protocol LoginViewDelegate <NSObject>
@optional
- (void)presentRegistView;
- (void)presentHomeView;

@end
