//
//  AppDelegate.h
//  Final
//
//  Created by Iturbide, Omar on 12/3/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
//#import "DayViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navCtrl;
@property (strong, nonatomic) RootViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
