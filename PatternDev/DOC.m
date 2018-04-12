//
//  DOC.m
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import "DOC.h"

@implementation DOC

{
    PatternDoc *_patternDoc;
}

static DOC *_instance = nil;

#pragma mark -Services

+ (DOC*)sharedInstance
{
    @synchronized(self) {
        
        if (_instance == nil) {
            _instance = [[DOC alloc] init];
        }
    }
    return _instance;
}

- (PatternDoc*)patternDoc
{
    if (_patternDoc == nil) {
        _patternDoc = [[PatternDoc alloc] init];
    }
    return _patternDoc;
}

@end
