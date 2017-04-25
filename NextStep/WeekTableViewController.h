//
//  WeekTableViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/3/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayViewController.h"

@interface WeekTableViewController : UITableViewController<UINavigationControllerDelegate>{
    NSMutableArray *allWeeks;
    NSManagedObjectContext *managedObjectContext;
    DayViewController *dayCtrl;
}
@property (nonatomic, strong) NSMutableArray *allWeeks;
@property NSManagedObjectContext *managedObjectContext;

@end
