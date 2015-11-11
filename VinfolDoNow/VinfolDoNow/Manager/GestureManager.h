//
//  GestureManager.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"

@interface GestureManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(GestureManager)

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end
