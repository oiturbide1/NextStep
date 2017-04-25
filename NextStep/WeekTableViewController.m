//
//  WeekTableViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/3/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "WeekTableViewController.h"
#import "Week.h"
#import "Day.h"

@interface WeekTableViewController ()

@end

@implementation WeekTableViewController
@synthesize allWeeks, managedObjectContext;
//Next Step: Create Database


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Weekly View";
    [self.view setBackgroundColor: [UIColor whiteColor]];
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Week" inManagedObjectContext: managedObjectContext];
    request.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects: sortDescriptor, nil];
    request.sortDescriptors = sortDescriptors;
    NSError *error = nil;
    allWeeks = [[managedObjectContext executeFetchRequest: request error: &error] mutableCopy];
    
    dayCtrl = [[DayViewController alloc]init];
    dayCtrl.managedObjectContext = managedObjectContext;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) addItem{
    
    Week *temp = [NSEntityDescription insertNewObjectForEntityForName: @"Week" inManagedObjectContext: managedObjectContext];
    temp.name = [NSString stringWithFormat: @"Week %d", allWeeks.count + 1];
    Day *temp2[7];
    NSMutableSet *children = [temp mutableSetValueForKey: @"toDay"];
    NSArray *arr = [[NSArray alloc] initWithObjects: @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    for(int i = 0; i < 7; i++){
        temp2[i] = [NSEntityDescription insertNewObjectForEntityForName: @"Day" inManagedObjectContext: managedObjectContext];
        temp2[i].name = arr[i];
        temp2[i].toWeek = temp;
        temp2[i].kNumber = [NSNumber numberWithInt: i];
        temp2[i].active = [NSNumber numberWithInt: 1];
        [temp2[i] setValue: temp forKey: @"toWeek"];
        [children addObject: temp2[i]];
        
    }
    temp.toDay = children;
    //[temp setValue: [[NSSet alloc]initWithArray: temp2] forKey: @"toDay"];
    NSError *error;
    [managedObjectContext save: &error];
    [allWeeks addObject: temp];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: [allWeeks count] - 1 inSection: 0];
	[self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: UITableViewRowAnimationFade];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return allWeeks.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	dayCtrl.week = [allWeeks objectAtIndex: indexPath.row];
	[self.navigationController pushViewController: dayCtrl animated:YES];
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
    
	Week *temp = [allWeeks objectAtIndex: indexPath.row];
    if (temp.name == nil)
        cell.textLabel.text = @"New Item";
    else
        cell.textLabel.text = [NSString stringWithFormat:@"%@", temp.name];
    
	cell.textLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 14];
	cell.textLabel.textColor = [UIColor blueColor];
	cell.textLabel.highlightedTextColor = [UIColor yellowColor];
	//cell.imageView.image = [UIImage imageNamed: @"4seasons.png"];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [managedObjectContext deleteObject: [allWeeks objectAtIndex: indexPath.row]];
        NSError *error = nil;
        [managedObjectContext save: &error];
        [allWeeks removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
    }
    
}

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
