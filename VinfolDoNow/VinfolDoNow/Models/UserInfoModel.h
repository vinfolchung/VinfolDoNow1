//
//  UserInfoModel.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *password;

+ (UserInfoModel *)makeModelWithPhone:(NSString *)phone
                             password:(NSString *)password;

@end
