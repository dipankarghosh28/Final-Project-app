//
//  ViewController.h
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, assign) BOOL isSomethingEnabled;
@property (weak, nonatomic) IBOutlet UILabel *labeldip;
@property (weak, nonatomic) IBOutlet UILabel *labeldip2;
@property (weak, nonatomic) IBOutlet UILabel *labeldip3;
@property (weak, nonatomic) IBOutlet UILabel *labeldip4;

extern int MG;
extern int MG1;
extern BOOL gl;
@end

