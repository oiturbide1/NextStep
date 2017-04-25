//
//  Day.h
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise, Week;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSNumber * kNumber;
@property (nonatomic, retain) NSSet *toExercise;
@property (nonatomic, retain) Week *toWeek;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addToExerciseObject:(Exercise *)value;
- (void)removeToExerciseObject:(Exercise *)value;
- (void)addToExercise:(NSSet *)values;
- (void)removeToExercise:(NSSet *)values;

@end
