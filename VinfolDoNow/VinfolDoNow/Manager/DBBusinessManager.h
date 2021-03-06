//
//  DBBusinessManager.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/10.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"
#import "FMDB.h"
@class BasicInfoModel;

@interface DBBusinessManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(DBBusinessManager)

- (void)userInfoInsertWithPhone:(NSString *)phone
                       password:(NSString *)password
                          login:(NSString *)login
                      autoLogin:(NSString *)autoLogin
                   rememberPass:(NSString *)rememberPass;

- (void)basicInfoInsertWithPhone:(NSString *)phone
                            name:(NSString *)name
                           email:(NSString *)email
                           birth:(NSString *)birth
                            head:(NSString *)head;

- (NSMutableArray *)getDataFromUserInfo;

- (BasicInfoModel *)getDataFromBasicInfoWithPhone:(NSString *)phone;

- (void)updateLoginWithPhone:(NSString *)phone
                       login:(NSString *)login;

- (void)updateAutoLoginWithPhone:(NSString *)phone
                       autoLogin:(NSString *)autoLogin;

- (void)updateRememberPassWithPhone:(NSString *)phone
                       rememberPass:(NSString *)rememberPass;

@end
