//
//  DBManager.h
//  VinfolDoNow
//
//  Created by 钟文锋 on 15/11/10.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"
#import "FMDB.h"

@interface DBManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(DBManager)

@property (nonatomic, strong) FMDatabase *dataBase;
- (BOOL)dataBaseUpdateWithSql:(NSString *)sql,...;
- (FMResultSet *)dataBaseQueryWithSql:(NSString *)sql,...;

@end
