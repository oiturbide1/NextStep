//
//  DBManager.h
//  Final
//
//  Created by Iturbide, Omar on 12/4/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <Foundation/Foundation.h>
//Ignore this header!!
@interface DBManager : NSObject{
    //NSMutableArray *arrColumnNames;
    
}
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertRowID;

-(NSArray *) loadDataFromDB: (NSString *) query;

-(instancetype) initWithDatabaseFilename: (NSString *) dbFilename;
-(void)executeQuery: (NSString *) query;

@end
