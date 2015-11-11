//
//  GestureManager.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "GestureManager.h"

@interface GestureManager ()

@end

@implementation GestureManager
SYNTHESIZE_SINGLETON_FOR_CLASS(GestureManager)

#pragma mark - event methods
- (void)viewTapped:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - getter and setter
- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    }
    return _tapGesture;
}


@end
