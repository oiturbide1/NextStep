//
//  SearchTableViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/10/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController
@synthesize managedObjectContext, searchData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialize items required to search
    searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake( 0, 0, 320, 64)];
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar: searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    
    self.tableView.tableHeaderView = searchBar;
    
    
    searchData = [[NSMutableArray alloc] initWithObjects: nil];
    
    
    
    
    
    //Starting items in table are those of Entity type RUN
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Run" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    
    self.searchData = [[managedObjectContext executeFetchRequest:fetchRequest error:&error]mutableCopy];
    setCtrl = [[SetViewController alloc]init];
    setCtrl.managedObjectContext = managedObjectContext;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}

#pragma mark -
#pragma mark Content Filtering
//Items typed into search bar are searched for
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchData removeAllObjects];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Exercise" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    entity = [NSEntityDescription entityForName: @"Run" inManagedObjectContext: managedObjectContext];
    request.entity = entity;
    
    self.searchData = [[managedObjectContext executeFetchRequest:fetchRequest error:&error]mutableCopy];
    [self.tableView reloadData];
}
#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.searchData.count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

- (UITableViewCell *)tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    if([[self.searchData objectAtIndex: indexPath.row] isKindOfClass: [Run class]]){
        Run *temp = [self.searchData objectAtIndex: indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ || Time: %@", temp.date, temp.time];
    }else{
        Exercise *temp = [self.searchData objectAtIndex: indexPath.row];
        if (temp.name == nil)
            cell.textLabel.text = @"New Item";
        else
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", temp.name, temp.toDay.toWeek.name, temp.toDay.name];
    }
	   
	cell.textLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 10];
	cell.textLabel.textColor = [UIColor blueColor];
	cell.textLabel.highlightedTextColor = [UIColor yellowColor];
	
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([[self.searchData objectAtIndex: indexPath.row] isKindOfClass: [Exercise class]]){
        setCtrl.exercise = [self.searchData objectAtIndex: indexPath.row];
        [self.navigationController pushViewController: setCtrl animated:YES];
    }
	
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
