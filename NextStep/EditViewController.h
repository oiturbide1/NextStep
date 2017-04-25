//
//  EditViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "SEts.h"

@interface EditViewController : UIViewController<UINavigationControllerDelegate, UITextFieldDelegate>{
    NSManagedObjectContext *managedObjectContext;
    Exercise *exercise;
    UITextField *text[3];
    UILabel *labl1, *labl2, *labl3;
    NSString *name;
    int rep, set;
    UIButton *ok;
    Day *day;
}
@property (nonatomic, strong) Day *day;
@property (nonatomic, strong) Exercise *exercise;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) UILabel *labl1, *labl2, *labl3;
@property (nonatomic,strong) NSString *name;

@end
