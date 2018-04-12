//
//  SecondViewController.m
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/13/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
static void (^completionBlock)();

@interface SecondViewController (){
UIColor *_lineColor;
UIImage *_activeImage;
UIImage *_inactiveImage;
NSString *_patternString;
ShowType2 _type;
NSInteger _numberOfFails;
BOOL _shouldConfirm;
NSString *_patternToConfirm;
}
@end
@implementation SecondViewController

- (void) Show
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 30, 50 , 50);
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  /*  [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
   */
    [self.view addSubview:button];


}


- (void) showPatternLockFor:(ShowType2) type withActiveDotImage:(UIImage *) activeDot withInactiveDotImage:(UIImage *)inactiveDot withLineColor:(UIColor *) color withCompletionHandler:(void (^)(SecondViewController *viewController, NSString * patternString)) block
{
    _activeImage = activeDot;
    _inactiveImage = inactiveDot;
    _lineColor = color;
    _type = type;
    completionBlock = block;
    
    
    [[[[UIApplication sharedApplication] delegate] window].rootViewController presentViewController:self animated:YES completion:nil];
    
}
- (void)makeNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 30, 50 , 50);
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 /*   [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
  */
    [self.view addSubview:button];
    
    UIButton *details = [UIButton buttonWithType:UIButtonTypeSystem];
    details.frame = CGRectMake(100, 100, 120, 40);
    [details setTitle:@"Match Pattern!" forState:UIControlStateNormal];
    [details setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    //[details addTarget:self action:@selector(transition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:details];
    
      [[[[UIApplication sharedApplication] delegate] window].rootViewController presentViewController:self animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}
-(void) viewWillAppear
{
    [super viewWillAppear:YES];
   
        NSLog(@"view appeared - Dipankar");
        // Do here the stuff you wanted to do on first appear
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
