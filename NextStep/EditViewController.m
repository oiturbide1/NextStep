//
//  EditViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/7/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "EditViewController.h"
#define frameHeight self.view.frame.size.height
#define frameWidth self.view.frame.size.width

@interface EditViewController ()

@end

@implementation EditViewController
@synthesize managedObjectContext, exercise;
@synthesize labl1, labl2, labl3, name, day;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    name = @"";
    set = 0;
    rep = 0;
    for(int i = 0; i < 3; i++){
        text[i] = [[UITextField alloc]initWithFrame: CGRectMake(120, 70 + (i * 60), frameWidth*.5, 30)];
        text[i].borderStyle = UITextBorderStyleRoundedRect;
        text[i].textColor = [UIColor redColor];
        text[i].delegate = self;
        [self.view addSubview: text[i]];
    }
    labl1 = [[UILabel alloc]initWithFrame: CGRectMake(10, 70, 110, 30)];
    labl1.text = @"Name";
    labl1.font = [UIFont fontWithName: @"Helvetica" size: 20];
    labl1.textColor = [UIColor blueColor];
    [self.view addSubview: labl1];
    
    labl2 = [[UILabel alloc] initWithFrame: CGRectMake(10, 130, 110, 30)];
    labl2.text = @"Reps";
    labl2.font = [UIFont fontWithName: @"Helvetica" size: 20];
    labl2.textColor = [UIColor blueColor];
    [self.view addSubview: labl2];
    
    labl3 = [[UILabel alloc] initWithFrame: CGRectMake(10, 190, 110, 30)];
    labl3.text = @"Sets";
    labl3.font = [UIFont fontWithName: @"Helvetica" size: 20];
    labl3.textColor = [UIColor blueColor];
    [self.view addSubview: labl3];
    ok = [[UIButton alloc] initWithFrame: CGRectMake((frameWidth - 100)/2, (frameHeight/2) + 100, 100, 40)];
    [ok addTarget:self action:@selector(buttonClicked:) forControlEvents: UIControlEventTouchUpInside];
    ok.backgroundColor = [UIColor orangeColor];
    [ok setTitle: @"OK" forState: UIControlStateNormal];
    [self.view addSubview: ok];
    
    // Do any additional setup after loading the view.
}

-(void) buttonClicked:(UIButton *) button{
    if(!([name isEqualToString: @""] || rep == 0 || set == 0)){

        
        Exercise *temp = [NSEntityDescription insertNewObjectForEntityForName: @"Exercise" inManagedObjectContext: managedObjectContext];
        temp.name = name;
        temp.reps = [NSNumber numberWithInt: rep];
        temp.toDay = day;
        exercise = temp;
        
        NSMutableSet *children = [temp mutableSetValueForKey: @"toSets"];
        Sets *temp2[set];
        
        for(int i = 0; i < set; i++){
            temp2[i] = [NSEntityDescription insertNewObjectForEntityForName: @"Sets" inManagedObjectContext: managedObjectContext];
            temp2[i].set = [NSNumber numberWithInt: i + 1];
            temp2[i].weight = 0;
            [temp2[i] setValue: temp forKey: @"toExercise"];
            [children addObject: temp2[i]];
        }
        
        temp.toSets = children;
        NSError *error;
        [managedObjectContext save: &error];
        
        [self.navigationController popViewControllerAnimated: YES];
        
        
    }else
        NSLog(@"Empty");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];


    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn: (UITextField *) txtField {
	[txtField resignFirstResponder];
	return YES;
}


- (void) textFieldDidEndEditing: (UITextField *) txtField
{
	if (txtField == text[0])
		name = text[0].text;
	else if (txtField == text[1])
		rep = [txtField.text intValue];
    else if(txtField == text[2])
        set = [txtField.text intValue];
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
