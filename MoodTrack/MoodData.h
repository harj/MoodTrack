//
//  MoodData.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodData : NSObject{
    NSString *mood_value;
    NSDate *ts;
    NSNumber *lat;
    NSNumber *lon;
    NSNumber *accuracy;
}

@property(nonatomic,strong) NSString *mood_value;
@property(nonatomic,strong) NSDate *ts;
@property(nonatomic,strong) NSNumber *lat;
@property(nonatomic,strong) NSNumber *lon;
@property(nonatomic,strong) NSNumber *accuracy;

@end
