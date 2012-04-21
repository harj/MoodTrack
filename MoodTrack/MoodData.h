//
//  MoodData.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoodData : NSObject{
    int _uniqueId;
    NSString *_value;
    NSDate *_time;
}

@property (nonatomic, assign) int uniqueId;
@property(nonatomic,copy) NSString *value;
@property(nonatomic,copy) NSDate *time;

-(id)initWithUniqueId:(int)uniqueId value:(NSString *)value time:(NSDate *)time;

@end
