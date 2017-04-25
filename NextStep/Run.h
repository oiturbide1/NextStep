//
//  Run.h
//  Final
//
//  Created by Iturbide, Omar on 12/10/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Run : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * time;

@end
