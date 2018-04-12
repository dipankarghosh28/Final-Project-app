//
//  ViewController.m
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import "ViewController.h"
#import "Pattern.h"
#import "Final.h"
#import "SecondViewController.h"
#import "PatternDoc.h"
#import "DOC.h"
#import "DrawPattern.h"
int MG=1;
int MG1=0;

BOOL gl=TRUE;

@interface ViewController ()
{
    PatternDoc *_patternDoc;
//@property (nonatomic, strong) UITextField *pickerViewTextField;
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Value of MG = %d", MG);

    // [self.view setBackgroundColor:[UIColor colorWithRed:0.99 green:0.96 blue:0.43 alpha:1.0]];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Image.jpg"]];
    self.view.backgroundColor = background;
    _labeldip.hidden = YES;
    _labeldip2.hidden = YES;
    _labeldip3.hidden = YES;
    _labeldip4.hidden = YES;

    UIButton *display1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [display1 setTitle:@"After pattern-match click here !" forState:UIControlStateNormal];
    [display1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [display1 sizeToFit];
    display1.frame = CGRectMake(20,80,300,50);
    display1.hidden=NO;
   // display1.backgroundColor= [UIColor clearColor];
    [display1 setFont:[UIFont boldSystemFontOfSize:19]];
    [display1 addTarget:self action:@selector(Press2:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:display1];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _patternDoc = [DOC sharedInstance].patternDoc;
}

- (IBAction)setPattern:(id)sender {

    Pattern *patternLockVC = [[Pattern alloc] init];
    [patternLockVC showPatternLockFor:showForEnable withActiveDotImage:[UIImage imageNamed:@"yellowcircle.png"] withInactiveDotImage:[UIImage imageNamed:@"yellowcircle.png"] withLineColor:nil withCompletionHandler:^(Pattern *viewController, NSString *patternString) {
        NSLog(@"%@", patternString);
        _patternDoc.patternString = patternString;
    }];
}
- (IBAction)Label:(id)sender {
 _labeldip.hidden = NO;
 _labeldip2.hidden = NO;
 _labeldip3.hidden = NO;
 _labeldip4.hidden = NO;

}

- (IBAction)matchPattern:(id)sender {
   // MG1=1;
    gl=TRUE;
    NSLog(@"BOOL value %x", gl);
    if(gl==TRUE){
    NSLog(@"Match PAttern entry,Value of MG1 = %d", MG1);
    Pattern *patternLockVC = [[Pattern alloc] init];
    [patternLockVC showPatternLockFor:showForAuthenticate withActiveDotImage:[UIImage imageNamed:@"yellowcircle.png"] withInactiveDotImage:[UIImage imageNamed:@"yellowcircle.png"] withLineColor:nil withCompletionHandler:^(Pattern *viewController, NSString *patternString) {
        NSLog(@"%@", patternString);
    }];
        gl= FALSE;
    }
     NSLog(@"BOOL value %x", gl);
    
}

- (void)Press:(UIButton *)display
{
    NSLog(@"Button Final Pressed");
    MG=0;
    NSLog(@"Value of MG = %d", MG);
    if(MG==0)
    { display.hidden=YES;
        MG=1;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 150, 200, 100)];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blueColor];
        label1.numberOfLines = 0;
        label1.hidden = YES;
        [label1 setFont:[UIFont boldSystemFontOfSize:18]];
        //label.lineBreakMode = UILineBreakModeWordWrap;
        label1.text = @"Verify again please, click on verify below";
        [self.view addSubview:label1];
            MG1=1;
       if(MG1==1)
           label1.hidden=YES; // change this if you want to show
            NSLog(@"Value of MG1 = %d", MG1);
        [display addTarget:self action:@selector(trial:)
        forControlEvents:UIControlEventTouchUpInside];
        
        //label1.hidden=YES;
        //self.label1.hidden = YES;
         MG=0;
    }
    else
    {   MG=1;
        NSLog(@"Value of MG = %d", MG);
        [display addTarget:self action:@selector(trial:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
    display.tag = 10;
  /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *newView = [storyboard instantiateViewControllerWithIdentifier:@"infoSegue"];
    [self.navigationController pushViewController:newView animated:YES];
*/
}
- (void)trial:(UIButton *)display
{
    /*Final code here*/
    NSLog(@"Finally entering here");
    NSLog(@"Value of MG = %d", MG);
    NSLog(@"Value of MG1 = %d\n", MG1);
    NSLog(@"Value of BOOL = %x\n", gl);

}
- (IBAction)next:(UIButton *)sender {
 //   sender.hidden=YES;
}

- (void)Press2:(UIButton *)display1
{
    NSLog(@"Button 1 pressed");
    NSLog(@"Value of MG = %d", MG);

    if(MG==0 && gl==0)
    {
        UIButton *display = [UIButton buttonWithType:UIButtonTypeSystem];
        [display setTitle:@"Am I visible ? Click me !" forState:UIControlStateNormal];
        [display sizeToFit];
        display.frame = CGRectMake(40, 140, 250 ,40);
        display.backgroundColor = [UIColor clearColor];
        [display setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        display.hidden= NO;
        [display setFont:[UIFont boldSystemFontOfSize:18]];
        [display addTarget:self action:@selector(moveSegue:)// this makes us enter the final method
          forControlEvents:UIControlEventTouchUpInside];
        gl=1;
        [self.view addSubview:display];
       

    }
    
}


- (void) moveSegue:(UIButton *)display
{
    NSLog(@"Currently I AM HERE\n");
    NSLog(@"Button Final Pressed");
    MG=0;
    NSLog(@"Value of MG = %d", MG);
    if(MG==0)
    { display.hidden=YES;
        MG=1;
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 150, 200, 100)];
        label1.backgroundColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blackColor];
        label1.numberOfLines = 0;
        label1.hidden = YES;
        [label1 setFont:[UIFont boldSystemFontOfSize:18]];
        //label.lineBreakMode = UILineBreakModeWordWrap;
        label1.text = @"Verify again please, click on verify below";
        [self.view addSubview:label1];
        MG1=1;
        if(MG1==1)
            label1.hidden=YES; // change this if you want to show
        NSLog(@"Value of MG1 = %d", MG1);
        [display addTarget:self action:@selector(trial:)
          forControlEvents:UIControlEventTouchUpInside];
        
        //label1.hidden=YES;
        //self.label1.hidden = YES;
        MG=0;
    }
    else
    {   MG=1;
        NSLog(@"Value of MG = %d", MG);
        [display addTarget:self action:@selector(trial:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
    display.tag = 10;
    SecondViewController *SVC = [[SecondViewController alloc] init];
   // [SVC makeNavigationBar];
    //[SVC viewDidLoad];
    [SVC viewWillAppear];
    
   // [self ViewController:SVC animated:YES];

   // SecondViewController makeNavigationBar{};

 //[self performSegueWithIdentifier:@"infoSegue" sender:self];
   // [super viewWillAppear:animated];
 Final *pattern = [[Final alloc] init];
  //  Pattern *patternLockVC = [[Pattern alloc] init];
    [pattern showPatternLockFor:showForEnable withActiveDotImage:[UIImage imageNamed:@"yellowcircle.png"] withInactiveDotImage:[UIImage imageNamed:@"yellowcircle.png"] withLineColor:nil withCompletionHandler:^(Final *viewController, NSString *patternString)
     {
        NSLog(@"%@", patternString);
    }];
  
    NSLog(@"REACHING HERE\n");

}
- (IBAction)hidden:(id)sender {
    
}

@end
