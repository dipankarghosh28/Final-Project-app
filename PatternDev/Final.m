//
//  Final.m
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/17/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import "Final.h"
#import "Pattern.h"
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_LOCK_ENABLED @"lock_enabled"
#define LOCK_STRING @"lock_string"
#import "DrawPattern.h"
#import "ViewController.h"

static void (^completionBlock)();

#define MATRIX_SIZE 3

@interface Final ()
{
UIColor *_lineColor;
UIImage *_activeImage;
UIImage *_inactiveImage;
NSString *_patternString;
ShowType _type;
NSInteger _numberOfFails;
BOOL _shouldConfirm;
NSString *_patternToConfirm;
}
@property (nonatomic) int toucheddots;
@property (nonatomic) int dotcount;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailedLabel;
@property (nonatomic, strong) UIButton *detail;
@property (nonatomic) BOOL alreadyAppeared;
- (NSString*)getKey;

- (void)setTarget:(id)target withAction:(SEL)action;

@end
@implementation Final
#define GMAIL_URL_SCHEME @"googlegmail://"

static NSString *encodeByAddingPercentEscapes(NSString *input) {
    NSString *encodedValue = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(
    kCFAllocatorDefault,
                                                                                                    (__bridge CFStringRef) input,
                                                                                                    NULL,
                                                                                                    (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8);
    return encodedValue;
}


+ (BOOL)canSendGmail {
#ifdef __IPHONE_9_0
    NSArray *applicationQuerySchemes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"LSApplicationQueriesSchemes"];
    if (![applicationQuerySchemes containsObject:@"googlegmail"])
    {
        NSLog(@"Gmail: Please add \"googlemail\" to \"LSApplicationQueriesSchemes\" in your Info.plist");
    }
#endif
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:GMAIL_URL_SCHEME]];
}

+ (BOOL)canSendyoutube{
#ifdef __IPHONE_9_0
    NSArray *applicationQuerySchemes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"LSApplicationQueriesSchemes"];
    if (![applicationQuerySchemes containsObject:@"youtube"])
    {
        NSLog(@"Youtube: Please add \"youtube\" to \"LSApplicationQueriesSchemes\" in your Info.plist");
    }
#endif
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:GMAIL_URL_SCHEME]];
}
+ (BOOL)canSendcalculator{
#ifdef __IPHONE_9_0
    NSArray *applicationQuerySchemes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"LSApplicationQueriesSchemes"];
    if (![applicationQuerySchemes containsObject:@"Safari"])
    {
        NSLog(@"Calculator: Please add \"Safari\" to \"LSApplicationQueriesSchemes\" in your Info.plist");
    }
#endif
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:GMAIL_URL_SCHEME]];
}
- (void) showPatternLockFor:(ShowType) type withActiveDotImage:(UIImage *) activeDot withInactiveDotImage:(UIImage *)inactiveDot withLineColor:(UIColor *) color withCompletionHandler:(void (^)(Final *viewController, NSString * patternString)) block
{
    _activeImage = activeDot;
    _inactiveImage = inactiveDot;
    _lineColor = color;
    _type = type;
    completionBlock = block;
    
    
    [[[[UIApplication sharedApplication] delegate] window].rootViewController presentViewController:self animated:YES completion:nil];
    
}


#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    self.view = [[DrawPattern alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)makeNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(-10, 0, 30 , 30);
    button.hidden = YES;
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UIButton *details = [UIButton buttonWithType:UIButtonTypeCustom];
   details.frame = CGRectMake(20, 100, 80, 80);
    //[details setTitle:@"GMAIL" forState:UIControlStateNormal];
    //[details setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [details setImage:[UIImage imageNamed:@"Gmail.jpg"] forState:UIControlStateNormal];
    [details sizeToFit];
    [details addTarget:self action:@selector(trans:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:details];
    
    UIButton *safari = [UIButton buttonWithType:UIButtonTypeCustom];
    safari.frame = CGRectMake(145, 100, 70, 70);
  //  [safari setTitle:@"SAFARI" forState:UIControlStateNormal];
   // [safari setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [safari setImage:[UIImage imageNamed:@"Yahoo.png"] forState:UIControlStateNormal];
    [safari sizeToFit];
    [safari addTarget:self action:@selector(transcalc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:safari];
    
    UIButton *youtube = [UIButton buttonWithType:UIButtonTypeCustom];
    youtube.frame = CGRectMake(230, 100, 70, 70);
//    [youtube setTitle:@"YOUTUBE" forState:UIControlStateNormal];
  //  [youtube setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [youtube setImage:[UIImage imageNamed:@"youtube.png"] forState:UIControlStateNormal];
    [youtube sizeToFit];
    [youtube addTarget:self action:@selector(transyou:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:youtube];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(-10, 35, 50 , 50);
   // button1.hidden = YES;
    button1.backgroundColor=[UIColor clearColor];
    [button1 setTitle:@"<" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [self dismissViewControllerAnimated:YES completion:NULL ];
    
    NSLog(@"Animation Completed but what's the use ?");
    
}

-(void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)trans:(UIButton*)detail
{
    NSLog(@"Inside TRANS !");
    if ([Final canSendGmail]) {
      //  _gmailInstalledLabel.text = @"YES";
        _detail.enabled = YES;
        NSLog(@"Entered here !");

    }
    /*NSString *mystr=[[NSString alloc] initWithFormat:@"googlegmail://location?id=0"];
    NSURL *myurl=[[NSURL alloc] initWithString:mystr];
    [[UIApplication sharedApplication] openURL:myurl];
  */

    NSString *customURL = @"googlegmail://location?id=0";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL error"
                                                        message:[NSString stringWithFormat:@"No custom URL defined for %@", customURL]
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)transyou:(UIButton*)youtube
{
    NSLog(@"Inside TRANS YOUTUBE !");
    if ([Final canSendyoutube]) {
        //  _gmailInstalledLabel.text = @"YES";
        youtube.enabled = YES;
        NSLog(@"Entered here !");
        
    }
    /*NSString *mystr=[[NSString alloc] initWithFormat:@"googlegmail://location?id=0"];
     NSURL *myurl=[[NSURL alloc] initWithString:mystr];
     [[UIApplication sharedApplication] openURL:myurl];
     */
    
    NSString *customURL = @"youtube://location?id=1";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL error"
                                                        message:[NSString stringWithFormat:@"No custom URL defined for %@", customURL]
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)transcalc:(UIButton*)safari
{
    NSLog(@"Inside TRANS CALC !");
    if ([Final canSendcalculator]) {
        //  _gmailInstalledLabel.text = @"YES";
       safari.enabled = YES;
        NSLog(@"Entered here !");
        
    }
    /*NSString *mystr=[[NSString alloc] initWithFormat:@"googlegmail://location?id=0"];
     NSURL *myurl=[[NSURL alloc] initWithString:mystr];
     [[UIApplication sharedApplication] openURL:myurl];
     */
    
    NSString *customURL = @"http://www.yahoo.com";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"URL error"
                                                        message:[NSString stringWithFormat:@"No custom URL defined for %@", customURL]
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeNavigationBar];
    float x ;
    float y;
    if([UIScreen mainScreen].bounds.size.height == 568) {
        x = 50;
        y = 180;
    } else {
        x = 80;
        y = 200;
    }
   // int line = MATRIX_SIZE;

  //self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.96 blue:0.43 alpha:1.0];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Image.jpg"]];
    self.view.backgroundColor = background;
   //[background release];
    CGRect rect = CGRectMake(0, 40, 320, 40);
    self.titleLabel = [[UILabel alloc] initWithFrame:rect];
    rect.origin.y += 40;
    self.detailedLabel = [[UILabel alloc] initWithFrame:rect];
    self.detail = [[UIButton alloc] initWithFrame:rect];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailedLabel];
    [self.view addSubview:self.detail];
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.detailedLabel.textColor = [UIColor blackColor];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.detailedLabel.textAlignment = NSTextAlignmentCenter;
    //    self.detail.Alignment = NSTextAlignmentCenter;
    
    self.titleLabel.text = @"Select the app you wish to access";
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (!self.alreadyAppeared) {
        self.alreadyAppeared = YES;
        NSLog(@"view appeared - Final");
        // Do here the stuff you wanted to do on first appear
    }
}

-(void)TapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    // [self.navigationController pushViewController:targetControllerObj animated:YES];
}

-(void) buttonClicked:(UIButton*)button
{
    
}
-(void) transition:(UIButton*)detail
{
    /*  UIViewController *second = [[UIViewController alloc] initWithNibName:nil bundle:nil];
     [self presentViewController:second animated:YES completion:^{[self animationCompleted];}];
     */
    MG=0;
    self.alreadyAppeared = YES;
    //NSLog(@"MG-> %d");
    NSLog(@"Value of MG = %d", MG);
    
    // Do here the stuff you wanted to do on first appear
    
    
    [self dismissViewControllerAnimated:YES completion:nil ];
    //.isSomethingEnabled = YES;
    
    // Flag=1; //setting the flag point as 1
    
    // if(flag==1)
    {
        
        
    }
    // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //  UIViewController *add = [self.storyboard instantiateViewControllerWithIdentifier:@"Present"];
    // [self presentViewController:add animated:YES completion:nil];
}

/*- (IBAction) detail: (id)sender
 {
 NSLog(@"Tap");
 }
 */
-(void) animationCompleted
{
    [self makeNavigationBar];
    
    // Whatever you want to do after finish animation
   
    
}

- (NSString *) getPatternLock
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:LOCK_STRING];
}

- (void) savePatternLock
{
    [[NSUserDefaults standardUserDefaults] setObject:_patternString forKey:LOCK_STRING];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOCK_ENABLED];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
