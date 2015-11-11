//
//  DBBusinessManager.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/10.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "DBBusinessManager.h"
#import "DBManager.h"
#import "UserInfoModel.h"

@implementation DBBusinessManager
SYNTHESIZE_SINGLETON_FOR_CLASS(DBBusinessManager)

#pragma mark - insert methods
- (void)userInfoInsertWithPhone:(NSString *)phone
                       password:(NSString *)password
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO USER_INFO (PHONE, PASSWORD) VALUES ('%@', '%@')",phone,password];
    if ([[DBManager sharedDBManager] dataBaseInsertWithSql:sql]) {
        NSLog(@"插入userinfo表成功！");
    }
    [[DBManager sharedDBManager].dataBase close];
}

- (void)basicInfoInsertWithPhone:(NSString *)phone
                            name:(NSString *)name
                           email:(NSString *)email
                           birth:(NSString *)birth
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BASIC_INFO (PHONE, NAME, EMAIL, BIRTH) VALUES ('%@', '%@', '%@', '%@')",phone,name,email,birth];
    if ([[DBManager sharedDBManager] dataBaseInsertWithSql:sql]) {
        NSLog(@"插入basicinfo表成功！");
    }
    [[DBManager sharedDBManager].dataBase close];
}

#pragma mark - select methods
- (NSMutableArray *)getDataFromUserInfo
{
    NSMutableArray *userArr = [[NSMutableArray alloc] init];
    NSString *sql = @"SELECT * FROM USER_INFO";
    FMResultSet *set = [[DBManager sharedDBManager] dataBaseSelectWithSql:sql];
    while ([set next]) {
        NSString *phone = [set stringForColumn:@"PHONE"];
        NSString *password = [set stringForColumn:@"PASSWORD"];
        NSLog(@"%@,%@",phone,password);
        [userArr addObject:[UserInfoModel makeModelWithPhone:phone password:password]];
    }
    [[DBManager sharedDBManager].dataBase close];
    return userArr;
}

- (NSString *)getPasswordFromUserInfoWithPhone:(NSString *)phone
{
    NSString *password = [[NSString alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM USER_INFO WHERE PHONE = '%@'",phone];
    FMResultSet *set = [[DBManager sharedDBManager] dataBaseSelectWithSql:sql];
    while ([set next]) {
        password = [set stringForColumn:@"PASSWORD"];
    }
    [[DBManager sharedDBManager].dataBase close];
    return password;
}

- (NSMutableArray *)getDataFromBasicInfo
{
    NSMutableArray *basicArr = [[NSMutableArray alloc] init];
    [[DBManager sharedDBManager].dataBase close];
    return basicArr;
}

@end
