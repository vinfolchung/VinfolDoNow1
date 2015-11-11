//
//  HomeViewController.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftBarBtn;

@end

@implementation HomeViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - override methods
- (UIBarButtonItem *)getLeftBarButtonItem
{
    return self.leftBarBtn;
}

#pragma mark - event respond
- (void)leftBarBtnOnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter and setter
- (UIBarButtonItem *)leftBarBtn
{
    if (!_leftBarBtn) {
        _leftBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnOnClicked:)];
        _leftBarBtn.tintColor = [UIColor whiteColor];
    }
    return _leftBarBtn;
}

@end
