//
//  DayViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/5/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "DayViewController.h"
#define frameWidth self.view.frame.size.width
#define frameHeight self.view.frame.size.height

@interface DayViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DayViewController
@synthesize managedObjectContext, week, arr, allDays;

//http://commons.wikimedia.org/wiki/File:Teymourtash_Village,_Bojnord_County.jpg
//Background image by Arashk rp2
//Creative Commons

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    background = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frameWidth, frameHeight)];
    
    NSString *file = nil;
    file = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"bojnord.jpg"];
    background.image = [UIImage imageWithContentsOfFile: file];
    [self.view addSubview: background];

    arr = [[NSArray alloc]initWithObjects: @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
    
    //Fetch items
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Day" inManagedObjectContext: managedObjectContext];
    request.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"kNumber" ascending: YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects: sortDescriptor, nil];
    request.sortDescriptors = sortDescriptors;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"toWeek == %@", week];
    request.predicate = predicate;
    NSError *error = nil;
    
    allDays = [[managedObjectContext executeFetchRequest: request error: &error] mutableCopy];
    for(int i = 0; i < [allDays count]; i++){
        Day *temp = [allDays objectAtIndex: i];
        NSLog(@"%@", [NSString stringWithFormat: @"%@", temp.kNumber]);
    }

    for(int i = 0; i < 7; i++){
        button[i] = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [button[i] setFrame:CGRectMake((frameWidth - 250) / 2, 100 + (i * 50), 250, 40)];
        Day *temp = [allDays objectAtIndex: i];
        if([temp.active intValue] == 1){
            [button[i] setBackgroundColor: [UIColor whiteColor]];
        }else{
            [button[i] setBackgroundColor: [UIColor lightGrayColor]];
        }
        [button[i] addTarget:self action:@selector(buttonClicked:) forControlEvents: UIControlEventTouchUpInside];
        
        [button[i] setTitle: arr[i] forState: UIControlStateNormal];
        [self.view addSubview: button[i]];
        
    }
    //Add longPressGesture to all buttons in the subview
    for(UIButton *but in self.view.subviews){
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget: self action:@selector(longPressDetected:)];
        longPress.delegate = self;
        longPress.minimumPressDuration = 1.5f;
        [but addGestureRecognizer: longPress];
    }
    //Create alert that goes off on first run.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"FirstRun"]) {
        // display alert...
        alert = [[UIAlertView alloc] initWithTitle:@"Quick Note"
                                           message:@"Holding down on a day to deactive"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        
        [alert show];
        [defaults setBool:NO forKey:@"FirstRun"];
    }
    

    
}

-(void) viewWillAppear: (BOOL) animated{
    [super viewWillAppear: animated];
    self.title = [NSString stringWithFormat: @"%@", week.name];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

-(void)longPressDetected:(UILongPressGestureRecognizer*) gesture{
    for(int i = 0; i < 7; i++){
        if(gesture.view == button[i]){
            if(gesture.state == UIGestureRecognizerStateBegan){
                NSLog(@"Long Press %@", [NSString stringWithFormat: @"%d", i]);
                Day *day = [self getDay: i];
                if([day.active intValue] == 1){
                    day.active = 0;
                    [button[i] setBackgroundColor: [UIColor lightGrayColor]];
                }else{
                    day.active = [NSNumber numberWithInt:1];
                    [button[i] setBackgroundColor: [UIColor whiteColor]];
                }
                NSError *error = nil;
                [managedObjectContext save: &error];
            }
        }
    }

}

-(void)buttonClicked:(UIButton*)press{
    for(int i = 0; i<7;i++){
        if(press ==  button[i] && [button[i].backgroundColor isEqual: [UIColor whiteColor]]){
            exCtrl = [[ExerciseTableViewController alloc]init];
            exCtrl.managedObjectContext = managedObjectContext;
            Day *day = [self getDay: i];
            
            NSLog(@"%@", [NSString stringWithFormat: @"%@ and %@", day.name, day.toWeek.name]);
            exCtrl.day = day;
            [self.navigationController pushViewController: exCtrl animated: YES];
        }
    }
}

//Retreive specific date pressed from database
-(id)getDay: (int) i{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Day" inManagedObjectContext: managedObjectContext];
    request.entity = entity;

    
    //Use Predicates to query database
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"toWeek.name like %@", week.name];
    NSPredicate *predicate2= [NSPredicate predicateWithFormat: @"name like %@", arr[i]];
    NSArray *array = [NSArray arrayWithObjects: predicate1, predicate2, nil];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates: array];
    request.predicate = predicate;
    NSError *error;
    NSArray *results = [managedObjectContext executeFetchRequest: request error: &error];
    return [results lastObject];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

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
