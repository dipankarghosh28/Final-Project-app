//
//  DrawPattern.h
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPattern : UIView {
    NSValue *_trackPointValue;
    NSMutableArray *_dotViews;
}

@property (nonatomic, strong) UIButton *setHidePatternMatch;

- (void)clearDotViews;
- (void)addDotView:(UIView*)view;
- (void)drawLineFromLastDotTo:(CGPoint)pt;
@end
