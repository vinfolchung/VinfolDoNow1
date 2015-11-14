//
//  SideSlideView.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/14.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "SideSlideView.h"
#import <Accelerate/Accelerate.h>
#define sideView_width 200*kAdaptPixel

@interface SideSlideView ()

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIImageView *blurImageView;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) UIButton *menuBtn;

@end

@implementation SideSlideView
#pragma mark - life cycle
- (instancetype)initWithRootVC:(UIViewController *)rootVC
{
    self = [super initWithFrame:CGRectMake(-sideView_width, 0, sideView_width, kScreen_Height)];
    if (self) {
        self.rootViewController = rootVC;
        [self.rootViewController.view addGestureRecognizer:self.leftSwipe];
        [self.rootViewController.view addGestureRecognizer:self.rightSwipe];
        [self.rootViewController.view addSubview:self.menuBtn];
        [self addSubview:self.blurImageView];
    }
    return self;
}

#pragma mark - public methods
- (void)setSideViewWithContentView:(UIView *)contentView
{
    if (contentView) {
        self.contentView = contentView;
    }
    self.contentView.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:self.contentView];
}

#pragma mark - private methods
- (void)showSideSlideView:(BOOL) isShown
{
    UIImage *image = [self imageFromView:self.rootViewController.view];
    if (!_isOpen) {
        self.blurImageView.alpha = 1.0f;
    }
    CGFloat sideView_x = isShown ? 0:-sideView_width;
    CGFloat menuBtnAlpha = isShown ? 0:1;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(sideView_x, 0, self.width, self.height);
        if (!_isOpen) {
            self.blurImageView.image = image;
            self.blurImageView.image = [self blurryImage:self.blurImageView.image withBlurLevel:0.2];
        }
    } completion:^(BOOL finished) {
        _isOpen = isShown;
        if (!_isOpen) {
            self.blurImageView.image = nil;
            self.blurImageView.alpha = 0;
        }
        [self.menuBtn setAlpha:menuBtnAlpha];
    }];
    //要根据侧滑view是否打开来确定rootview是否可以点击
    if (!self.isOpen) {
        [self.rootViewController.view addGestureRecognizer:self.tapGesture];
    }
    else {
        [self.rootViewController.view removeGestureRecognizer:self.tapGesture];
    }
}

#pragma mark - gesture&event respond
- (void)hideSideSlideView
{
    [self showSideSlideView:NO];
}

- (void)showSideSlideView
{
    [self showSideSlideView:YES];
    [self.menuBtn setAlpha: 0];
}

- (void)tapHideSideSlideView
{
    [self showSideSlideView:NO];
}

- (void)menuBtnOnClick
{
    [self showSideSlideView:!self.isOpen];
    [self.menuBtn setAlpha:0];
}

#pragma mark - get rootView methods
- (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - Blur methods
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}


#pragma mark - getter and setter
- (UIImageView *)blurImageView
{
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] initWithFrame:CGRectMake(sideView_width, 0, kScreen_Width, kScreen_Height)];
        _blurImageView.userInteractionEnabled = NO;
        _blurImageView.alpha = 0;
        _blurImageView.backgroundColor = [UIColor grayColor];
    }
    return _blurImageView;
}

- (UISwipeGestureRecognizer *)leftSwipe
{
    if (!_leftSwipe) {
        _leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideSideSlideView)];
        _leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _leftSwipe;
}

- (UISwipeGestureRecognizer *)rightSwipe
{
    if (!_rightSwipe) {
        _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSideSlideView)];
        _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _rightSwipe;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideSideSlideView)];
        _tapGesture.numberOfTapsRequired = 1;
    }
    return _tapGesture;
}

- (UIButton *)menuBtn
{
    if (!_menuBtn) {
        _menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*kAdaptPixel, 30*kAdaptPixel, 30*kAdaptPixel, 30*kAdaptPixel)];
        [_menuBtn setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
        _menuBtn.alpha = 0.7f;
        _menuBtn.backgroundColor = [UIColor clearColor];
        [_menuBtn addTarget:self action:@selector(menuBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}
@end
