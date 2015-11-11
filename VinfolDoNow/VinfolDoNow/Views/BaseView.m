//
//  BaseView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSMutableArray *colorArr;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation BaseView

#pragma mark - life cycle
- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.layer addSublayer:self.gradientLayer];
        [self addSubview:self.bgImageView];
    }
    return self;
}

#pragma mark - getter and setter
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        //设定颜色变化方向
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
        //设定颜色
        _gradientLayer.colors = self.colorArr;
    }
    return _gradientLayer;
}

- (NSMutableArray *)colorArr
{
    if (!_colorArr) {
        _colorArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 20; i++) {
            UIColor *color = [UIColor colorWithHue:(200+i)/360.0f
                                        saturation:1.0f
                                        brightness:0.5f + i/40.0f
                                             alpha:1.0 - i/50.0f];
            [_colorArr addObject:color];
        }
    }
    return _colorArr;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"bg.png"];
    }
    return _bgImageView;
}

@end
