//
//  UserInfoModel.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (UserInfoModel *)makeModelWithPhone:(NSString *)phone
                             password:(NSString *)password
{
    UserInfoModel *model = [[UserInfoModel alloc] init];
    model.phone = phone;
    model.password = password;
    return model;
}

@end
