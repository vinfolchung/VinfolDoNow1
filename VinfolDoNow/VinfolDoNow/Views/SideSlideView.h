//
//  SideSlideView.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/14.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideSlideView : UIView

- (instancetype)initWithRootVC:(UIViewController *)rootVC;
- (void)menuBtnOnClick;
- (void)setSideViewWithContentView:(UIView *)contentView;

@end
