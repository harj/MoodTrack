//
//  MoodData.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoodData.h"

@implementation MoodData

@synthesize uniqueId = _uniqueId;
@synthesize value = _value;
@synthesize time = _time;

- (id)initWithUniqueId:(int)uniqueId value:(NSString *)value time:(NSString *)time {
    if ((self = [super init])) {
        self.uniqueId = uniqueId;
        self.value = value;
        self.time = time;
    }
    return self;
}

@end
