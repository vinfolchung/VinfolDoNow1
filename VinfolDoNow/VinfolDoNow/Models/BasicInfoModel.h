//
//  BasicInfoModel.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicInfoModel : NSObject

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *birth;

+ (BasicInfoModel *)makeModelWithPhone:(NSString *)phone
                                  name:(NSString *)name
                                 email:(NSString *)email
                                 birth:(NSString *)birth;

@end
