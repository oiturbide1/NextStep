//
//  TimerViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/5/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolBox/AudioServices.h>
#import "Run.h"

@interface TimerViewController : UIViewController<UINavigationControllerDelegate, UIPickerViewDelegate, UIAlertViewDelegate>{
    UILabel *progress;
    NSTimer *timer;
    int hour, min, sec, state;
    int save;
    UIButton *start, *pause;
    UIPickerView *picker1, *picker2;
    NSMutableArray *arr1, *arr2;
    UIView *plate;
    NSManagedObjectContext *managedObjectContext;
    Run *run;
    UIImageView *background;
    UIAlertView *alert;
    
}
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@end
