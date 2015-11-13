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
                          login:(NSString *)login
                      autoLogin:(NSString *)autoLogin
                   rememberPass:(NSString *)rememberPass
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO USER_INFO (PHONE, PASSWORD, LOGIN, AUTOLOGIN, REMEMBERPASS) VALUES ('%@', '%@', '%@', '%@', '%@')",phone,password,login,autoLogin,rememberPass];
    if ([[DBManager sharedDBManager] dataBaseUpdateWithSql:sql]) {
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
    if ([[DBManager sharedDBManager] dataBaseUpdateWithSql:sql]) {
        NSLog(@"插入basicinfo表成功！");
    }
    [[DBManager sharedDBManager].dataBase close];
}

#pragma mark - select methods
- (NSMutableArray *)getDataFromUserInfo
{
    NSMutableArray *userArr = [[NSMutableArray alloc] init];
    NSString *sql = @"SELECT * FROM USER_INFO";
    FMResultSet *set = [[DBManager sharedDBManager] dataBaseQueryWithSql:sql];
    while ([set next]) {
        NSString *phone = [set stringForColumn:@"PHONE"];
        NSString *password = [set stringForColumn:@"PASSWORD"];
        NSString *login = [set stringForColumn:@"LOGIN"];
        NSString *autoLogin = [set stringForColumn:@"AUTOLOGIN"];
        NSString *rememberPass = [set stringForColumn:@"REMEMBERPASS"];
        NSLog(@"%@,%@,%@,%@,%@",phone,password,login,autoLogin,rememberPass);
        [userArr addObject:[UserInfoModel makeModelWithPhone:phone password:password login:login autoLogin:autoLogin rememberPass:rememberPass]];
    }
    [[DBManager sharedDBManager].dataBase close];
    return userArr;
}

- (NSMutableArray *)getDataFromBasicInfo
{
    NSMutableArray *basicArr = [[NSMutableArray alloc] init];
    [[DBManager sharedDBManager].dataBase close];
    return basicArr;
}

#pragma mark - update methods
- (void)updateLoginWithPhone:(NSString *)phone
                       login:(NSString *)login
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE USER_INFO SET LOGIN = '%@' WHERE PHONE = '%@'",login,phone];
    if ([[DBManager sharedDBManager] dataBaseUpdateWithSql:sql]) {
        NSLog(@"更新登录状态成功！");
    }
    [[DBManager sharedDBManager].dataBase close];
}

- (void)updateAutoLoginWithPhone:(NSString *)phone
                       autoLogin:(NSString *)autoLogin
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE USER_INFO SET AUTOLOGIN = '%@' WHERE PHONE = '%@'",autoLogin,phone];
    if ([[DBManager sharedDBManager] dataBaseUpdateWithSql:sql]) {
        NSLog(@"更新自动登录状态成功！");
    }
    [[DBManager sharedDBManager].dataBase close];
}

- (void)updateRememberPassWithPhone:(NSString *)phone
                       rememberPass:(NSString *)rememberPass
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE USER_INFO SET REMEMBERPASS = '%@' WHERE PHONE = '%@'",rememberPass,phone];
    if ([[DBManager sharedDBManager] dataBaseUpdateWithSql:sql]) {
        NSLog(@"更新记住密码状态成功！");
    }
    [[DBManager sharedDBManager].dataBase close];

}

@end
