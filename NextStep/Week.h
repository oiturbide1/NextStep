//
//  Week.h
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Week : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *toDay;
@end

@interface Week (CoreDataGeneratedAccessors)

- (void)addToDayObject:(Day *)value;
- (void)removeToDayObject:(Day *)value;
- (void)addToDay:(NSSet *)values;
- (void)removeToDay:(NSSet *)values;

@end
