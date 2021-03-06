//
//  MenuView.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/13.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate;
@interface MenuView : UIView

@property (nonatomic, weak) id<MenuViewDelegate> delegate;

@end

@protocol MenuViewDelegate <NSObject>

- (void)settingCellOnClicked;

@end
