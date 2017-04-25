//
//  SetViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/9/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "SetViewController.h"
#define frameWidth self.view.frame.size.width
#define frameHeight self.view.frame.size.height
@interface SetViewController ()

@end

@implementation SetViewController
@synthesize exercise, managedObjectContext;
//Background by Kelly Sikkema Creative commons
//https://www.flickr.com/photos/95072945@N05/8667776107/in/photostream/

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
    background = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frameWidth, frameHeight)];
    
    NSString *file = nil;
    file = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"penpaper.jpg"];
    background.image = [UIImage imageWithContentsOfFile: file];
    [self.view addSubview: background];
    
}

-(void) viewWillAppear: (BOOL) animated{
    [super viewWillAppear: animated];
    
    self.title = [NSString stringWithFormat: @"%@  Reps = %@", exercise.name, exercise.reps];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Sets" inManagedObjectContext: managedObjectContext];
    request.entity = entity;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"set" ascending: YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects: sortDescriptor, nil];
    request.sortDescriptors = sortDescriptors;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"toExercise == %@", exercise];
    request.predicate = predicate;
    NSError *error;
    allSets = [[managedObjectContext executeFetchRequest: request error: &error] mutableCopy];
    
    
    
    int count = allSets.count;
    UITextField *text[count];
    UILabel *lbl[count];
    allTextFields = [[NSMutableDictionary alloc]init];
    
    //Create textfields and labels for every set entity related to the exercise
    for(int i = 0; i< count; i++){
        lbl[i] = [[UILabel alloc] initWithFrame: CGRectMake(80, 70 + (i * 30), 110, 20)];
        Sets *temp = [allSets objectAtIndex: i];
        lbl[i].text = [NSString stringWithFormat:@"Set #%@", temp.set];
        lbl[i].font = [UIFont fontWithName: @"Helvetica" size: 10];
        [self.view addSubview: lbl[i]];
        
        text[i] = [[UITextField alloc] initWithFrame: CGRectMake(120, 70+ (i * 30), 110, 20)];
        NSString *str = [NSString stringWithFormat: @"%@", temp.weight];
        if([str isEqualToString: @"(null)"]){
            text[i].text = @"0";
        }else{
            text[i].text = [NSString stringWithFormat: @"%@", temp.weight];
        }
        NSLog(@"%@", [NSString stringWithFormat: @"%@", temp.weight]);
        text[i].tag = i;  //Add tage to identify which UITextField is responding.
        text[i].borderStyle = UITextBorderStyleRoundedRect;
        text[i].textColor = [UIColor redColor];
        text[i].delegate = self;
        
        [self.view addSubview: text[i]];
    }

}
-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) textFieldDidEndEditing: (UITextField *) txtField
{
    //int i = 0;
    for(int i = 0; i < [allSets count]; i++){
        if(txtField.tag == i){
            Sets *temp = [allSets objectAtIndex: i];
            temp.weight = [NSNumber numberWithFloat: [txtField.text floatValue]];
            break;
        }
    }
    //NSLog(@"%@",[NSString stringWithFormat: @"%d",i]);
    NSError *error;
    [managedObjectContext save: &error];
    
	
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
