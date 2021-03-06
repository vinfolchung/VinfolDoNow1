//
//  RegistViewController.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/9.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "BaseViewController.h"

@protocol RegistViewControllerDelegate;

@interface RegistViewController : BaseViewController

@property (nonatomic, weak) id<RegistViewControllerDelegate> delegate;

@end

@protocol RegistViewControllerDelegate <NSObject>
@optional

- (void)registerSuccess;

@end
