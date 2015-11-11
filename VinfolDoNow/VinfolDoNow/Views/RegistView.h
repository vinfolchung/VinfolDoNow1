//
//  RegistView.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegistViewDelegate;

@interface RegistView : UIView
@property (nonatomic, strong) UIButton *headImageBtn;
@property (nonatomic, strong) UITextField *firstPassTextField;
@property (nonatomic, strong) UITextField *secondPassTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, weak) id<RegistViewDelegate> delegate;

@end

@protocol RegistViewDelegate <NSObject>
@optional
//打开图库
- (void)presentPhotoView;

@end
