//
//  DrawPattern.m
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import "DrawPattern.h"

@implementation DrawPattern

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (!_trackPointValue)
        return;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _setHidePatternMatch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // [_setHidePatternMatch setTitle:@"Hide Pattern" forState:UIControlStateNormal];
    _setHidePatternMatch.titleLabel.textColor = [UIColor whiteColor];
    _setHidePatternMatch.frame = CGRectMake(0, screenHeight-100 , screenWidth, 40.0);
    [self addSubview:_setHidePatternMatch];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.8, 0.8, 0.8, 0.8};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    if (_setHidePatternMatch.selected) {
        //Need to update here.
    }else{
    }
    
    CGPoint from;
    UIView *lastDot;
    
    for (UIView *dotView in _dotViews) {
        from = dotView.center;
        
        if(from.y < 3)
            continue;
        
        if (!lastDot)
            CGContextMoveToPoint(context, from.x, from.y);
        else
            CGContextAddLineToPoint(context, from.x, from.y);
        lastDot = dotView;
    }
    CGPoint pt = [_trackPointValue CGPointValue];
    CGContextAddLineToPoint(context, pt.x, pt.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    _trackPointValue = nil;
}

- (void)clearDotViews {
    [_dotViews removeAllObjects];
}

- (void)addDotView:(UIView *)view {
    if (!_dotViews)
        _dotViews = [NSMutableArray array];
    [_dotViews addObject:view];
}

- (void)drawLineFromLastDotTo:(CGPoint)pt {
    _trackPointValue = [NSValue valueWithCGPoint:pt];
    [self setNeedsDisplay];
}

@end
