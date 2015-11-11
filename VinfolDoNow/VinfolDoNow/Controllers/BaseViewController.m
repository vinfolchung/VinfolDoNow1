//
//  BaseViewController.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"

@interface BaseViewController ()

@property (nonatomic, strong) BaseView *baseView;

@end

@implementation BaseViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.baseView];
    [self setNavigationBar];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - private methods
//添加导航条
- (void)setNavigationBar
{
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    if (!self.navigationController) {
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, (44+20)*kAdaptPixel)];
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarImage.png"] forBarMetrics:UIBarMetricsCompact];
        [navigationBar pushNavigationItem:navigationItem animated:YES];
        navigationBar.layer.masksToBounds = YES;
        [self.view addSubview:navigationBar];
    }else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarImage.png"] forBarMetrics:UIBarMetricsCompact];
    }
    //导航条标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120*kAdaptPixel, 64*kAdaptPixel)];
    titleLabel.text = [self getNavigationTitle];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.0*kAdaptPixel];
    titleLabel.textColor = [UIColor whiteColor];
    
    if (!self.navigationController) {
        navigationItem.titleView = titleLabel;
        navigationItem.leftBarButtonItem = [self getLeftBarButtonItem];
        navigationItem.rightBarButtonItem = [self getRightBarButtonItem];
    }else {
        self.navigationItem.titleView = titleLabel;
        self.navigationItem.leftBarButtonItem = [self getLeftBarButtonItem];
        self.navigationItem.rightBarButtonItem = [self getRightBarButtonItem];
    }
}

#pragma mark - override methods
- (NSString *)getNavigationTitle
{
    return @"";
}

- (UIBarButtonItem *)getLeftBarButtonItem
{
    return nil;
}

- (UIBarButtonItem *)getRightBarButtonItem
{
    return nil;
}

#pragma mark - getter and setter
- (BaseView *)baseView
{
    if (!_baseView) {
        _baseView = [[BaseView alloc] init];
    }
    return _baseView;
}

@end
