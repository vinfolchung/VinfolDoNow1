//
//  MenuView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/13.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "MenuView.h"
#import "DBBusinessManager.h"
#import "UserInfoModel.h"
#import "BasicInfoModel.h"
#import "AppDelegate.h"

@interface MenuView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *menuView;
@property (nonatomic, strong) NSArray *menuArr;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *headImageBtn;
@property (nonatomic, strong) UILabel *nameLabel;

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
    return self.menuArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60 *kAdaptPixel;
    }
    return 40*kAdaptPixel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    //[cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.row == 0) {
        [cell addSubview:self.headImageBtn];
        [cell addSubview:self.nameLabel];
    }
    else{
        cell.textLabel.text = self.menuArr[indexPath.row - 1];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20.0*kAdaptPixel];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (UIButton *)headImageBtn
{
    if (!_headImageBtn) {
        _headImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*kAdaptPixel, 10*kAdaptPixel, 40*kAdaptPixel, 40*kAdaptPixel)];
        _headImageBtn.layer.cornerRadius = _headImageBtn.width/2;
        _headImageBtn.clipsToBounds = YES;
        AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (del.headImage != nil) {
            [_headImageBtn setBackgroundImage:del.headImage forState:UIControlStateNormal];
        }
        //[_headImageBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    }
    return _headImageBtn;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60*kAdaptPixel, 15*kAdaptPixel, 120*kAdaptPixel, 30*kAdaptPixel)];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:16.0*kAdaptPixel];
        AppDelegate *del = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        BasicInfoModel *basicModel = [[BasicInfoModel alloc] init];
        basicModel = [[DBBusinessManager sharedDBBusinessManager] getDataFromBasicInfoWithPhone:del.phone];
        _nameLabel.text = basicModel.name;
    }
    return _nameLabel;
}

@end
