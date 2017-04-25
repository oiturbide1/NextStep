//
//  TimerViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/5/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "TimerViewController.h"
#define frameWidth self.view.frame.size.width
#define frameHeight self.view.frame.size.height
#import "Run.h"
@interface TimerViewController ()

@end

@implementation TimerViewController
@synthesize managedObjectContext;

//http://pixabay.com/en/pause-button-media-icon-player-303651/
//Pause button Creative Commons
//Creator Nemo

//http://pixabay.com/en/audio-play-sound-start-video-158489/
//Play Button Creative Commons
//Creator OpenClips

//Photo 2 property of Omar Iturbide
//All rights reserved. 
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Timer";
    background = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frameWidth, frameHeight)];
    state = 0;
    save = 0;
    
    NSString *file = nil;
    file = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"photo2.jpg"];
    background.image = [UIImage imageWithContentsOfFile: file];
    [self.view addSubview: background];
    
    UIView *view = [[UIView alloc]initWithFrame: CGRectMake(0,0, frameWidth, 250)];
    view.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview: view];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame: CGRectMake(frameWidth / 6.5, frameHeight / 2.5, 100, 50)];
    label1.text = @"Hour";
    label1.backgroundColor = [UIColor clearColor];
    UILabel *label2 = [[UILabel alloc] initWithFrame: CGRectMake(frameWidth / 1.5, frameHeight / 2.5, 100, 50)];
    label2.text = @"Minutes";
    label2.backgroundColor = [UIColor clearColor];
    [self.view addSubview: label1];
    [self.view addSubview: label2];
    
    arr1 = [[NSMutableArray alloc]initWithObjects: nil];
    arr2 = [[NSMutableArray alloc] initWithObjects: nil];
    
    for(int i = 0; i < 24; i++){
        [arr1 addObject: [NSString stringWithFormat: @"%d", i]];
    }
    for(int i = 0; i < 60; i++){
        [arr2 addObject: [NSString stringWithFormat: @"%d", i]];
    }
    //Make 2 pickers for hour and time.
    picker1 = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, frameWidth/2, 250)];
    picker1.delegate = self;
    picker1.showsSelectionIndicator = YES;
    [self.view addSubview: picker1];
    
    [picker1 selectRow: 0 inComponent: 0 animated: YES];
    [picker1 reloadComponent: 0];
    
    picker2 = [[UIPickerView alloc] initWithFrame: CGRectMake(frameWidth/2, 0, frameWidth/2, 250)];
    picker2.delegate =self;
    picker2.showsSelectionIndicator = YES;
    
    
    [picker2 selectRow: 20 inComponent: 0 animated: YES];
    [picker2 reloadComponent: 0];
    
    [self.view addSubview: picker2];
    

    hour = 0;
    min = 20;
    sec = 00;
    
    start = [[UIButton alloc] initWithFrame: CGRectMake(frameWidth/5,frameHeight / 1.5 , 64, 64)];
    start.backgroundColor = [UIColor clearColor];
    [start setTitle: @"Start" forState: UIControlStateNormal];
    UIImage *btn1 = [UIImage imageNamed: @"go.png"];
    [start setImage: btn1 forState: UIControlStateNormal];
    [start addTarget: self action:@selector(startPressed) forControlEvents: UIControlEventTouchUpInside];
    pause = [[UIButton alloc] initWithFrame: CGRectMake(frameWidth/1.5, frameHeight / 1.5, 64, 64)];
    pause.backgroundColor = [UIColor clearColor];
    [pause setTitle: @"Pause" forState: UIControlStateNormal];
    UIImage *btn2 = [UIImage imageNamed: @"stop.png"];
    [pause setImage: btn2 forState: UIControlStateNormal];
    [pause addTarget: self action:@selector(pausePressed) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: pause];
    [self.view addSubview: start];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pausePressed{
    if(state == 1){
        state = 0;
        [timer invalidate];
    }else{
        [plate removeFromSuperview];
        [progress removeFromSuperview];
        progress = nil;
        plate = nil;
        save = 0;
    }
}

-(void) startPressed{
    if(state == 0){
        state = 1;
        sec = 0;
        save = save + (60  * hour) + min;
        [self start];
        plate = [[UIView alloc]initWithFrame: CGRectMake(0,0, frameWidth, 250)];
        plate.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview: plate];
        progress = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frameWidth, 250)];
        progress.font = [UIFont fontWithName: @"Helvetica" size: 45];
        progress.textColor = [UIColor blueColor];
        [progress setText:[NSString stringWithFormat:@"%@%d%@%d%@%02d",@"Time : ",hour, @":",min,@":",sec]];
        [self.view addSubview: progress];
    }
    
}

- (void) pickerView: (UIPickerView *) pickerView didSelectRow: (NSInteger) row inComponent: (NSInteger) component {
	
        if ([pickerView isEqual: picker1])
            hour =  [[arr1 objectAtIndex:[pickerView selectedRowInComponent: 0]] intValue];
        else
            min = [[arr2 objectAtIndex:[pickerView selectedRowInComponent: 0]] intValue];
}

-(void) start{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector: @selector(fired) userInfo: nil repeats: YES];
}

- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView {
	return 1;
}

- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component {
	if ([pickerView isEqual: picker1])
        return [arr1 count];
    else
        return [arr2 count];
    
}

- (NSString *) pickerView:(UIPickerView *) pickerView titleForRow: (NSInteger) row forComponent: (NSInteger) component {
    if ([pickerView isEqual: picker1])
        return [arr1 objectAtIndex: row];
    else
        return [arr2 objectAtIndex: row];
    
    
}



-(void) fired{
    if((min>0 || sec>=0) && min>=0){
        if(sec==0){
            min-=1;
            sec=59;
        }
        else if(sec>0){
            sec-=1;
        }
        if(min>-1){
            [progress setText:[NSString stringWithFormat:@"%@%d%@%d%@%02d",@"Time : ",hour, @":",min,@":",sec]];
        }
    }
    //Once timer reaches 0
    //save all information to core data
    else{
        [timer invalidate];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *currentTime = [dateFormatter stringFromDate:today];
        NSLog(@"User's current time in their preference format:%@",currentTime);
        
        Run *temp = [NSEntityDescription insertNewObjectForEntityForName: @"Run" inManagedObjectContext: managedObjectContext];
        temp.time = [NSNumber numberWithInt: save];
        temp.date = [NSDate date];
        NSError *error;
        [managedObjectContext save: &error];
        
        //Remove objects covering picker
        [plate removeFromSuperview];
        [progress removeFromSuperview];
        progress = nil;
        plate = nil;
        NSString *string = [NSString stringWithFormat: @"%d minutes elapsed", save];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        alert = [[UIAlertView alloc] initWithTitle:@"Times Up"
                                           message:string
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        
        [alert show];
        save = 0;
        
    }
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
