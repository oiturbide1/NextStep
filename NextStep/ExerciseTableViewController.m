//
//  ExerciseTableViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "ExerciseTableViewController.h"

@interface ExerciseTableViewController ()

@end

@implementation ExerciseTableViewController
@synthesize managedObjectContext, allExercises, day;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat: @"%@ %@", day.name, day.toWeek.name];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    editCtrl = [[EditViewController alloc] init];
    editCtrl.managedObjectContext = managedObjectContext;
    editCtrl.day = day;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addItem{
    [self.navigationController pushViewController: editCtrl animated:YES];
}

-(void)viewWillAppear:(BOOL) animated{
    [super viewWillAppear: animated];
    //If returning from editCtrl.Exercise
    if(editCtrl.exercise){
        [allExercises addObject: editCtrl.exercise];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow: [allExercises count] - 1 inSection: 0];
        [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: UITableViewRowAnimationFade];
        editCtrl.exercise = nil;
    }else{
        //Fetch from core data
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName: @"Exercise" inManagedObjectContext: managedObjectContext];
        request.entity = entity;
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"name" ascending: YES];
        NSArray *sortDescriptors = [NSArray arrayWithObjects: sortDescriptor, nil];
        request.sortDescriptors = sortDescriptors;
        NSError *error = nil;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"toDay == %@", day];
        request.predicate = predicate;
        allExercises = [[managedObjectContext executeFetchRequest: request error: &error] mutableCopy];
    }
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
    return allExercises.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    setCtrl = [[SetViewController alloc]init];
    setCtrl.managedObjectContext = managedObjectContext;
    setCtrl.exercise = [allExercises objectAtIndex: indexPath.row];
	[self.navigationController pushViewController: setCtrl animated:YES];
}



- (UITableViewCell *)tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    
	Exercise *temp = [allExercises objectAtIndex: indexPath.row];
    if (temp.name == nil)
        cell.textLabel.text = @"New";
    else
        cell.textLabel.text = [NSString stringWithFormat:@"%@", temp.name];
    
	cell.textLabel.font = [UIFont fontWithName: @"Helvetica-Bold" size: 14];
	cell.textLabel.textColor = [UIColor blueColor];
	cell.textLabel.highlightedTextColor = [UIColor yellowColor];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [managedObjectContext deleteObject: [allExercises objectAtIndex: indexPath.row]];
        NSError *error = nil;
        [managedObjectContext save: &error];
        [allExercises removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath] withRowAnimation: YES];
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
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
