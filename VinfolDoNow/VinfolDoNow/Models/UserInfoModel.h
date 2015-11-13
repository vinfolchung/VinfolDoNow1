//
//  UserInfoModel.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *autoLogin;
@property (nonatomic, copy) NSString *rememberPass;

+ (UserInfoModel *)makeModelWithPhone:(NSString *)phone
                             password:(NSString *)password
                                login:(NSString *)login
                            autoLogin:(NSString *)autoLogin
                         rememberPass:(NSString *)rememberPass;

@end
