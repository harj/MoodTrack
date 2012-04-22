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
    NSNumber *_value;
    NSString *_time;
}

@property (nonatomic, assign) int uniqueId;
@property(nonatomic,copy) NSNumber *value;
@property(nonatomic,copy) NSString *time;

-(id)initWithUniqueId:(int)uniqueId value:(NSNumber *)value time:(NSString *)time;

@end
