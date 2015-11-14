//
//  MenuView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/13.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *menuView;
@property (nonatomic, strong) NSArray *menuArr;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation MenuView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 200*kAdaptPixel, kScreen_Height)];
    if (self) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.menuView];
    }
    return self;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*kAdaptPixel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.menuArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20.0*kAdaptPixel];
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - getter and setter
- (UITableView *)menuView
{
    if (!_menuView) {
        _menuView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100*kAdaptPixel, self.width, self.height)];
        _menuView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuView.backgroundColor = [UIColor clearColor];
        _menuView.delegate = self;
        _menuView.dataSource = self;
        _menuView.scrollEnabled = NO;
    }
    return _menuView;
}

- (NSArray *)menuArr
{
    if (!_menuArr) {
        _menuArr = [[NSArray alloc] initWithObjects:@"主   页",@"分   组",@"日   历",@"设   置",@"闹钟设置" ,nil];
    }
    return _menuArr;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgImageView.image = [UIImage imageNamed:@"menuBg"];
        _bgImageView.alpha = 0.5f;
    }
    return _bgImageView;
}

@end
