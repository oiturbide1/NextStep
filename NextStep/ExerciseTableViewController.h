//
//  ExerciseTableViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"
#import "EditViewController.h"
#import "SetViewController.h"
#import "Week.h"

@interface ExerciseTableViewController : UITableViewController<UINavigationControllerDelegate>{
    NSManagedObjectContext *managedObjectContext;
    Day *day;
    NSMutableArray *allExercise;
    EditViewController *editCtrl;
    SetViewController *setCtrl;
}
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) Day *day;
@property(nonatomic, strong) NSMutableArray *allExercises;
@end
