//
//  DBManager.m
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/10.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "DBManager.h"

#define CREATE_TABLE_BASIC_INFO @"CREATE TABLE IF NOT EXISTS BASIC_INFO (PHONE TEXT PRIMARY KEY,NAME TEXT,EMAIL TEXT,BIRTH TEXT,HEAD TEXT)"
#define CREATE_TABLE_USER_INFO @"CREATE TABLE IF NOT EXISTS USER_INFO (PHONE TEXT PRIMARY KEY,PASSWORD TEXT NOT NULL,LOGIN TEXT NOT NULL,AUTOLOGIN TEXT NOT NULL,REMEMBERPASS TEXT NOT NULL)"

@interface DBManager ()

@end

@implementation DBManager
SYNTHESIZE_SINGLETON_FOR_CLASS(DBManager)
#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createDataTable:CREATE_TABLE_USER_INFO];
        [self createDataTable:CREATE_TABLE_BASIC_INFO];
    }
    return self;
}

#pragma mark - invoking methods

- (BOOL)dataBaseUpdateWithSql:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    [self.dataBase open];
    BOOL result = [self.dataBase executeUpdate:sql,args];
    return result;
}

- (FMResultSet *)dataBaseQueryWithSql:(NSString *)sql,...
{
    va_list args;
    va_start(args, sql);
    [self.dataBase open];
    FMResultSet *fmResultSet = [self.dataBase executeQuery:sql,args];
    return fmResultSet;
}

#pragma mark - private methods
- (BOOL)createDataTable:(NSString *)sql
{
    if ([self.dataBase open]) {
        BOOL result = [self.dataBase executeUpdate:sql];
        [self.dataBase close];
        return result;
    }else {
        return NO;
    }
}

#pragma mark - getter and setter
- (FMDatabase *)dataBase
{
    if (!_dataBase) {
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [path objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"VinfolDoNow.db"];
        _dataBase = [FMDatabase databaseWithPath:dbPath];
        [_dataBase setShouldCacheStatements:YES];
    }
    return _dataBase;
}

@end
