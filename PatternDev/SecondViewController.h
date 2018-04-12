//
//  SecondViewController.h
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/13/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

typedef enum {
    showForAuth = 0,
} ShowType2;

@interface SecondViewController : UIViewController
- (void) show;
- (void) makeNavigationBar;
- (void) viewDidLoad;
-(void) viewWillAppear;

@end

