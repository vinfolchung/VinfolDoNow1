//
//  BasicInfoModel.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "BasicInfoModel.h"

@implementation BasicInfoModel

+ (BasicInfoModel *)makeModelWithPhone:(NSString *)phone
                                  name:(NSString *)name
                                 email:(NSString *)email
                                 birth:(NSString *)birth
{
    BasicInfoModel *model = [[BasicInfoModel alloc] init];
    model.phone = phone;
    model.name = name;
    model.email = email;
    model.birth = birth;
    return model;
}

@end
