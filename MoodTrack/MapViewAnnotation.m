//
//  MapViewAnnotation.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize coordinate, title, subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)s
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
        [self setSubtitle:s];
    }
    NSLog(@"run");
    return self;
}

@end
