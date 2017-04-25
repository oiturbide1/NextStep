//
//  RootViewController.m
//  Final
//
//  Created by Iturbide, Omar on 12/3/14.
//  Copyright (c) 2014 Omar Iturbide. All rights reserved.
//

#import "RootViewController.h"
#define frameWidth self.view.frame.size.width
#define frameHeight self.view.frame.size.height

@implementation RootViewController
@synthesize managedObjectContext, weekTableCtrl;
//https://www.flickr.com/photos/flywithinsun/5643920755/in/photolist-9AJz1x-dgiYzP-8wbQp3-dgiX3R-9731P6-5PoDBQ-mRpwvK-fq2g28-8bbN9t-aep8Be-ps5zGG-8bf5gf-79R4nJ-342Uca-8bbANe-er4yvS-eq8vxv-eLZPqi-4AjK43-g5Atjv-9geA37-9t46ub-cxM7U7-g5B1nU-fq4Dwc-5TnKWq-7RnDQi-g5ACy3-g5AkuH-6KJiqc-dC8CQL-8dXRhR-g5ANaZ-g5BgoW-pyfGWV-9DX5Qp-5weCzA-dcEXZC-nT4FYU-nUNTBM-8z89Lr-nV717R-j4SWgg-j4YnBh-pLpJWL-q1VttG-j4RuaT-q2wvAG-nvnQXG-phSa6u

//Background image by Kingsley Huang for non profit use
//img by keith5201
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //[self.view setBackgroundColor: [UIColor orangeColor]];
    // Do any additional setup after loading the view.
    self.title = @"Next-Step Progress Log";
    background = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frameWidth, frameHeight)];
    state = 0;
     NSString *file = nil;
    file = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"2x4.jpg"];
    background.image = [UIImage imageWithContentsOfFile: file];
    [self.view addSubview: background];
    //Create buttons
    for(int i = 0; i < 3; i++){
        buttons[i] = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [buttons[i] setFrame:CGRectMake((frameWidth - 200) / 2, ((frameHeight - 40)/2) + (i * 50), 200, 40)];
        [buttons[i] setBackgroundColor: [UIColor whiteColor]];
        [buttons[i] addTarget:self action:@selector(buttonClicked:) forControlEvents: UIControlEventTouchUpInside];
        [self.view addSubview: buttons[i]];
        
    }
    UIButton *hid = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [hid setFrame: CGRectMake((frameWidth - 200) /2, (frameHeight - 40), 200, 40)];
    [hid addTarget:self action:@selector(hidClicked:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: hid];

    [buttons[0] setTitle: @"Weekly View" forState:UIControlStateNormal];
    [buttons[1] setTitle: @"Timer" forState:UIControlStateNormal];
    [buttons[2] setTitle: @"Search" forState:UIControlStateNormal];
    
    weekTableCtrl = [[WeekTableViewController alloc] init];
    weekTableCtrl.managedObjectContext = managedObjectContext;
    timerCtrl = [[TimerViewController alloc]init];
    timerCtrl.managedObjectContext = managedObjectContext;
    searchTableCtrl = [[SearchTableViewController alloc] init];
    searchTableCtrl.managedObjectContext = managedObjectContext;
}

-(void) buttonClicked: (UIButton *) button{
    if(button == buttons[0]){
        [self.navigationController pushViewController: weekTableCtrl animated:YES];
        
    }else if(button == buttons[1]){
        [self.navigationController pushViewController: timerCtrl animated: NO];
    }else{
        [self.navigationController pushViewController: searchTableCtrl animated: YES];
    }

}

-(void) viewWillAppear: (BOOL) animated{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) hidClicked:(UIButton *) button{
    if(state == 0){
        state = 1;
        img = [[UIImageView alloc] initWithFrame: CGRectMake((frameWidth - 200) / 2, (frameHeight - 113) / 5, 200, 113)];
        NSString *file = nil;
        file = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"Lennyface.jpg"];
        img.image = [UIImage imageWithContentsOfFile: file];
        [self.view addSubview: img];

    }else{
        state = 0;
        [img removeFromSuperview];
        img = nil;
    }
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
