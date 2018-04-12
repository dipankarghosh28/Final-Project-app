//
//  DOC.h
//  PatternDev
//
//  Created by Dipankar Ghosh on 3/4/18.
//  Copyright © 2018 Dipankar Ghosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PatternDoc.h"

@interface DOC: NSObject

@property(nonatomic,readonly)PatternDoc *patternDoc;

+ (DOC*)sharedInstance;

@end
