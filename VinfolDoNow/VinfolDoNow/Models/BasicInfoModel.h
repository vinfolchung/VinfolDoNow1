//
//  BasicInfoModel.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/11.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicInfoModel : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *birth;
@property (nonatomic, copy) NSString *head;

+ (BasicInfoModel *)makeModelWithPhone:(NSString *)phone
                                  name:(NSString *)name
                                 email:(NSString *)email
                                 birth:(NSString *)birth
                                  head:(NSString *)head;

@end
