//
//  Sets.h
//  Final
//
//  Created by Iturbide, Omar on 12/9/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Sets : NSManagedObject

@property (nonatomic, retain) NSNumber * set;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) Exercise *toExercise;

@end
