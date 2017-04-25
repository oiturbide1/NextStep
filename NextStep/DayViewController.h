//
//  DayViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/5/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"
#import "Day.h"
#import "ExerciseTableViewController.h"

@interface DayViewController : UIViewController<UINavigationControllerDelegate, UIAlertViewDelegate>{
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *allDays;
    UIButton *button[7];
    Week *week;
    NSArray *arr;
    ExerciseTableViewController *exCtrl;
    UIImageView *background;
    UIAlertView *alert;
}
@property (nonatomic, strong) NSMutableArray *allDays;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) Week *week;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
