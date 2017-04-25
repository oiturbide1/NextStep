//
//  Exercise.h
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day, Sets;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * reps;
@property (nonatomic, retain) Day *toDay;
@property (nonatomic, retain) NSSet *toSets;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)addToSetsObject:(Sets *)value;
- (void)removeToSetsObject:(Sets *)value;
- (void)addToSets:(NSSet *)values;
- (void)removeToSets:(NSSet *)values;

@end
