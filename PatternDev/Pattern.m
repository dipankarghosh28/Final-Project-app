//
//  Pattern.m
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import "Pattern.h"
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_LOCK_ENABLED @"lock_enabled"
#define LOCK_STRING @"lock_string"
#import "DrawPattern.h"
#import "ViewController.h"

static void (^completionBlock)();

#define MATRIX_SIZE 3
@interface Pattern (){
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




// get key from the pattern drawn
- (NSString*)getKey;

- (void)setTarget:(id)target withAction:(SEL)action;


@end

@implementation Pattern

- (void) showPatternLockFor:(ShowType) type withActiveDotImage:(UIImage *) activeDot withInactiveDotImage:(UIImage *)inactiveDot withLineColor:(UIColor *) color withCompletionHandler:(void (^)(Pattern *viewController, NSString * patternString)) block
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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 30, 50 , 50);
    [button setTitle:@"<" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *details = [UIButton buttonWithType:UIButtonTypeSystem];
    details.frame = CGRectMake(100, 100, 120, 40);
    [details setTitle:@"Match Pattern!" forState:UIControlStateNormal];
    details.hidden= YES;
    [details setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    //[details addTarget:self action:@selector(transition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:details];

    
}

-(void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    int line = MATRIX_SIZE;
    for (int i=0; i<MATRIX_SIZE * MATRIX_SIZE; i++) {
        UIImage *dotImage = _inactiveImage;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImage
                                                   highlightedImage:_activeImage];
        imageView.frame = CGRectMake(x, y, 30, 30);
        imageView.userInteractionEnabled = YES;
        imageView.tag = (i+1);
        [self.view addSubview:imageView];
        x+= 100;
        if((i+1) % line == 0)
        {
            y += 100;
            if([UIScreen mainScreen].bounds.size.height == 568) {
                x = 50;
            } else {
                x = 80;
            }
        }
    }
  //  self.view.backgroundColor = [UIColor blackColor];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"img.jpeg"]];
    self.view.backgroundColor = background;
   // [background release];
    CGRect rect = CGRectMake(0, 40, 320, 40);
    self.titleLabel = [[UILabel alloc] initWithFrame:rect];
    rect.origin.y += 40;
    self.detailedLabel = [[UILabel alloc] initWithFrame:rect];
    self.detail = [[UIButton alloc] initWithFrame:rect];

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailedLabel];
    [self.view addSubview:self.detail];

    self.titleLabel.textColor = [UIColor yellowColor];
    self.detailedLabel.textColor = [UIColor yellowColor];

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.detailedLabel.textAlignment = NSTextAlignmentCenter;
//    self.detail.Alignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17];
    self.titleLabel.text = @"Enter your pattern";
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (!self.alreadyAppeared) {
        self.alreadyAppeared = YES;
        NSLog(@"view appeared - Dipankar");
   // Do here the stuff you wanted to do on first appear
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _paths = [[NSMutableArray alloc] init];
    self.toucheddots = 0;
    self.dotcount = 0;
}

-(BOOL)array:(NSArray*)array containsNumber:(NSNumber*)number
{
    for(NSNumber *n in array){
        if([n isEqualToNumber:number]) return YES;
    }
    return NO;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    UIView *touched = [self.view hitTest:pt withEvent:event];
    DrawPattern *v = (DrawPattern*)self.view;
    [v drawLineFromLastDotTo:pt];
    
    if (touched!=self.view && touched.tag != 0) {
        self.toucheddots = touched.tag;
        self.dotcount++;
        
        BOOL found = NO;
        for (NSNumber *tag in _paths) {
            found = tag.integerValue==touched.tag;
            if (found)
                break;
        }
        if (found)
            return;
        [_paths addObject:[NSNumber numberWithInt:touched.tag]];
        if(touched.tag != 0)
        {
            [v addDotView:touched];
            UIImageView* iv = (UIImageView*)touched;
            iv.highlighted = YES;
        }
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    DrawPattern *v = (DrawPattern*)self.view;
    [v clearDotViews];
    
    for (UIView *view in self.view.subviews)
        if ([view isKindOfClass:[UIImageView class]])
            [(UIImageView*)view setHighlighted:NO];
    [self.view setNeedsDisplay];
    
    if(self.toucheddots && [[self getKey] length] != 1)
    {
        if (_target && _action)
            [_target performSelector:_action withObject:[self getKey]];
    }
}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    // simple way to generate a key
    for (NSNumber *tag in _paths) {
        [key appendFormat:@"%d", tag.integerValue];
    }
    _patternString = key;
    [self saveChanges];
    return key;
}


- (void)setTarget:(id)target withAction:(SEL)action
{
    _target = target;
    _action = action;
}

- (void) saveChanges
{
    switch (_type) {
        case 0:
            if([_patternString isEqualToString:[self getPatternLock]])
            {
              //  UIViewController * SecondViewController = [[UIViewController alloc] init];

               // [self dismissViewControllerAnimated:YES completion:nil];
               //  completionBlock(self, _patternString);
               //So here I have showed the detailed Labels by pausing few actions.
               // self.detailedLabel.text = @"Here";
                [self.detail setFrame:CGRectMake(60, 70, 200, 40)];
                [self.detail setBackgroundColor:[UIColor clearColor]];
                [self.detail setTitleColor:[UIColor colorWithRed:0.97 green:0.92 blue:0.26 alpha:1.0] forState:UIControlStateNormal];
                self.detail.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17];
                [self.detail setTitle:@"Click here to continue " forState:UIControlStateNormal];
                self.detail.hidden= NO;
                self.detail.layer.cornerRadius = 10;
                self.detail.clipsToBounds = YES;
             /*   [self.detail addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
              */
              [self.detail addTarget:self action:@selector(transition:) forControlEvents:
                 UIControlEventTouchUpInside];
                
              /*  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGestureRecognizer:)];
                [tap setNumberOfTouchesRequired:1];
                [_detail addGestureRecognizer:tap];
                */
               

                
                [self.detail setExclusiveTouch:YES];
                
                // if you like to add backgroundImage else no need
            } else {
                _numberOfFails++;
                [self.detailedLabel setFrame:CGRectMake(60,90,200,70)];
                self.detailedLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17];

                self.detailedLabel.text = @"Invalid pattern, Retry";
            }
            break;
        case 1:
            if(_shouldConfirm) {
                if([_patternString isEqualToString:_patternToConfirm]) {
                    [self savePatternLock];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    completionBlock(self, _patternString);
                } else {
                    self.detailedLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17];

                    self.detailedLabel.text = @"Pattern does not match";
                    self.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17];
                    self.titleLabel.text = @"Enter your new pattern";
                    _shouldConfirm = NO;
                }
            } else {
                _patternToConfirm = _patternString;
                self.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17];
                self.titleLabel.text = @"Confrim your new pattern";
                self.detailedLabel.text = @"";
                _shouldConfirm = !_shouldConfirm;
            }
            break;
        default:
            break;
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
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 30, 50 , 50);
    button1.backgroundColor=[UIColor redColor];
    [button1 setTitle:@"<" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [self dismissViewControllerAnimated:YES completion:NULL ];

    NSLog(@"Animation Completed but what's the use ?");

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

/*#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
