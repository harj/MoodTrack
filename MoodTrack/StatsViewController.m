//
//  StatsViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatsViewController.h"
#import <Parse/Parse.h>

@interface StatsViewController ()

@end

@implementation StatsViewController
@synthesize AverageScore;
@synthesize Average3Days;
@synthesize Average7Days;
@synthesize AverageAM;
@synthesize AveragePM;

-(NSString *)makeaverage:(double)number
{
    if (isnan(number)) {
        return @" - ";
    } else {
        return [NSString stringWithFormat:@"%.01f ", number];
    }
}

-(void)selectData:(float)type
{
    PFUser *currentuser = [PFUser currentUser];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    // Finding average mood
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    [query whereKey:@"user" equalTo:currentuser];
    
    if (type == 1) {
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
    } else {
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    }
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [data addObject:object];
            }
            
            // Arrays for storing mood values from queries
            NSMutableArray *moodVals = [[NSMutableArray alloc] init];
            NSMutableArray *moodVals3Days = [[NSMutableArray alloc] init];
            NSMutableArray *moodValsWeek = [[NSMutableArray alloc] init];
            NSMutableArray *moodValsAM = [[NSMutableArray alloc] init];
            NSMutableArray *moodValsPM = [[NSMutableArray alloc] init];
            
            for (PFObject *object in data) {
                
                //Get all mood values
                id mood_value = [object objectForKey:@"mood_value"];
                [moodVals addObject:mood_value];
                
                //Set up times conditions for queries
                NSDate *moodTime = object.createdAt;
                NSDate *threeDaysAgo = [[NSDate date] dateByAddingTimeInterval: -259200.0];
                NSDate *weekAgo = [[NSDate date] dateByAddingTimeInterval: -604800.0];
                
                //Deal with time zones
                NSString *tz = [[NSString alloc] init];
                if ([object objectForKey:@"timezone"] == NULL) {
                    tz = @"PDT";
                } else {
                    tz = [object objectForKey:@"timezone"];
                }
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:tz]];
        
                NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:moodTime];
                NSInteger hour = [components hour];
                
                // Get moods values past 3 days
                if ([moodTime laterDate:threeDaysAgo] == moodTime) {
                    [moodVals3Days addObject:mood_value];
                }
                
                //Get mood values past week
                if ([moodTime laterDate:weekAgo] == moodTime) {
                    [moodValsWeek addObject:mood_value];
                }
                
                //Get am and pm mood values
                if (hour >= 0 && hour < 12) {
                    [moodValsAM addObject:mood_value];
                    NSLog(@"%@", moodTime);
                } else {
                    [moodValsPM addObject:mood_value];
                }
                
            }
            
            
            NSLog(@"all:%i, 3d:%i, week:%i, am:%i, pm:%i", moodVals.count, moodVals3Days.count, moodValsWeek.count, moodValsAM.count, moodValsPM.count);
            
            //Find totals
            NSNumber *sum = [moodVals valueForKeyPath:@"@sum.self"];
            NSNumber *sum3Days = [moodVals3Days valueForKeyPath:@"@sum.self"];
            NSNumber *sumWeek = [moodValsWeek valueForKeyPath:@"@sum.self"];
            NSNumber *sumAM = [moodValsAM valueForKeyPath:@"@sum.self"];
            NSNumber *sumPM = [moodValsPM valueForKeyPath:@"@sum.self"];
            
            //Get averages
            double avg = [sum doubleValue] / moodVals.count;
            double avg3Days = [sum3Days doubleValue] / moodVals3Days.count;
            double avgWeek = [sumWeek doubleValue] / moodValsWeek.count;
            double avgAM = [sumAM doubleValue] / moodValsAM.count;
            double avgPM = [sumPM doubleValue] / moodValsPM.count;
            
            //Display averages
            self.AverageScore.text = [self makeaverage:avg];
            self.Average3Days.text = [self makeaverage:avg3Days];
            self.Average7Days.text = [self makeaverage:avgWeek];
            self.AverageAM.text = [self makeaverage:avgAM];            
            self.AveragePM.text = [self makeaverage:avgPM];              
            
        } else {
            NSLog(@"parse has failed me!");
        }
        
    }];  

}

- (void)viewDidLoad:(NSString *)text
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];

	// Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];
    [self selectData:0];
    
        
}

- (void)swipeRight:(UISwipeGestureRecognizer *)recognizer {
    [self performSegueWithIdentifier:@"MoodGraphViewController" sender:nil];
}

- (void)viewDidUnload
{
    [self setAverageAM:nil];
    [self setAveragePM:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)Refresh:(id)sender {
    [self selectData:1];
}

@end
