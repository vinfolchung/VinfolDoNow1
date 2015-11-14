//
//  HomeView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/14.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "HomeView.h"

@interface HomeView ()
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation HomeView
#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        //[self addSubview:self.bgImageView];
    }
    return self;
}

#pragma mark - getter and setter
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64*kAdaptPixel, kScreen_Width, kScreen_Height)];
        _bgImageView.image = [UIImage imageNamed:@"background"];
    }
    return _bgImageView;
}

@end
