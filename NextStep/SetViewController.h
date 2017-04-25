//
//  SetViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/9/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "Sets.h"

@interface SetViewController : UIViewController<UINavigationControllerDelegate, UITextFieldDelegate>{
    Exercise *exercise;
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *allSets;
    NSMutableDictionary *allTextFields;
    UIImageView *background;
}
@property (nonatomic, strong) Exercise *exercise;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
