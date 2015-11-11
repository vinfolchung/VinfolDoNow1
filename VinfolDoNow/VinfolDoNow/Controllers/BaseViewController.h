//
//  BaseViewController.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//导航条标题
- (NSString *)getNavigationTitle;
//设置导航条左边按钮
- (UIBarButtonItem *)getLeftBarButtonItem;
//设置导航条右边按钮
- (UIBarButtonItem *)getRightBarButtonItem;

@end
