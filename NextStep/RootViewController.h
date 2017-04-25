//
//  RootViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/3/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekTableViewController.h"
#import "TimerViewController.h"
#import "SearchTableViewController.h"

@interface RootViewController : UIViewController <UINavigationControllerDelegate>{
    NSManagedObjectContext *managedObjectContext;
    UIButton *buttons[3];
    WeekTableViewController *weekTableCtrl;
    TimerViewController *timerCtrl;
    SearchTableViewController *searchTableCtrl;
    UIImageView *background;
    UIImageView *img;
    int state;
}

@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) WeekTableViewController *weekTableCtrl;

@end
