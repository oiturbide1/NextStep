//
//  SearchTableViewController.h
//  Final
//
//  Created by Iturbide, Omar on 12/10/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "Day.h"
#import "Week.h"
#import "Run.h"
#import "SetViewController.h"

@interface SearchTableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate, UINavigationControllerDelegate> {
    NSMutableArray *searchData;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    NSManagedObjectContext *managedObjectContext;
    SetViewController *setCtrl;
}
@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSMutableArray *searchData;
@end
