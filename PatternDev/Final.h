//
//  Final.h
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/17/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
typedef enum {
    showForAuthenticate1 = 0,
    showForEnable1,
} ShowType1;
@interface Final : UIViewController{
NSMutableArray* _paths;

// after pattern is drawn, call this:
id _target;
SEL _action;
}
+ (BOOL)canSendGmail;
+ (BOOL)canSendyoutube;
+ (BOOL)canSendcalculator;

+ (BOOL)sendEmailTo:(NSString *)to subject:(NSString *)subject body:(NSString *)body;

- (void) showPatternLockFor:(ShowType1) type withActiveDotImage:(UIImage *) activeDot withInactiveDotImage:(UIImage *)inactiveDot withLineColor:(UIColor *) color withCompletionHandler:(void (^)(Final *viewController, NSString * patternString)) block;

@end
