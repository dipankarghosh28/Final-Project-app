//
//  Pattern.h
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

typedef enum {
    showForAuthenticate = 0,
    showForEnable,
} ShowType;
@interface Pattern : UIViewController
{
    
NSMutableArray* _paths;
    
    // after pattern is drawn, call this:
    id _target;
    SEL _action;
}

- (void) showPatternLockFor:(ShowType) type withActiveDotImage:(UIImage *) activeDot withInactiveDotImage:(UIImage *)inactiveDot withLineColor:(UIColor *) color withCompletionHandler:(void (^)(Pattern *viewController, NSString * patternString)) block;

@end


