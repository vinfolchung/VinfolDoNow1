//
//  HomeViewController.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "SideSlideView.h"
#import "MenuView.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftBarBtn;
@property (nonatomic, strong) HomeView *homeView;
@property (nonatomic, strong) SideSlideView *sideSlideView;
@property (nonatomic, strong) MenuView *menuView;

@end

@implementation HomeViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sideSlideView setSideViewWithContentView:self.menuView];
    [self.view addSubview:self.sideSlideView];
}

#pragma mark - getter and setter
- (HomeView *)homeView
{
    if (!_homeView) {
        _homeView = [[HomeView alloc] init];
    }
    return _homeView;
}

- (SideSlideView *)sideSlideView
{
    if (!_sideSlideView) {
        _sideSlideView = [[SideSlideView alloc] initWithRootVC:self];
    }
    return _sideSlideView;
}

- (MenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[MenuView alloc] init];
    }
    return _menuView;
}

@end
