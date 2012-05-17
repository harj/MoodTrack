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

- (void)viewDidLoad:(NSString *)text
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"furley_bg.png"]];
    
    UISwipeGestureRecognizer *sgr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [self.view addGestureRecognizer:sgr];
    
	// Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PFUser *currentuser = [PFUser currentUser];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    // Finding average mood
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"user" equalTo:currentuser];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [data addObject:object];
            }
            
            // Average mood
            NSMutableArray *moodVals = [[NSMutableArray alloc] init];
            NSMutableArray *moodVals3Days = [[NSMutableArray alloc] init];
            NSMutableArray *moodValsWeek = [[NSMutableArray alloc] init];
            
            for (PFObject *object in data) {
                
                //Get all mood values
                id mood_value = [object objectForKey:@"mood_value"];
                [moodVals addObject:mood_value];
                
                //Set up times for queries
                NSDate *time = object.createdAt;
                NSDate *threeDaysAgo = [[NSDate date] dateByAddingTimeInterval: -259200.0];
                NSDate *weekAgo = [[NSDate date] dateByAddingTimeInterval: -604800.0];
                
                // Get moods values past 3 days
                if ([time laterDate:threeDaysAgo] == time) {
                    [moodVals3Days addObject:mood_value];
                }
                
                //Get mood values past week
                if ([time laterDate:weekAgo] == time) {
                    [moodValsWeek addObject:mood_value];
                    NSLog(@"%@", mood_value);
                }
                
            }
            
            NSLog(@"%i, %i, %i", moodVals.count, moodVals3Days.count, moodValsWeek.count);

    
            //Find totals
            NSNumber *sum = [moodVals valueForKeyPath:@"@sum.self"];
            NSNumber *sum3Days = [moodVals3Days valueForKeyPath:@"@sum.self"];
            NSNumber *sumWeek = [moodValsWeek valueForKeyPath:@"@sum.self"];
            
            //Get averages
            double avg = [sum doubleValue] / moodVals.count;
            double avg3Days = [sum3Days doubleValue] / moodVals3Days.count;
            double avgWeek = [sumWeek doubleValue] / moodValsWeek.count;
            
            //Display averages
            if (moodVals.count) {
                self.AverageScore.text = [NSString stringWithFormat:@"%.02f", avg];
                self.Average3Days.text = [NSString stringWithFormat:@"%.02f", avg3Days];
                self.Average7Days.text = [NSString stringWithFormat:@"%.02f", avgWeek];
            } else {
                self.AverageScore.text = @"0";
                self.Average3Days.text = @"0";
                self.Average7Days.text = @"0";
            }
             
        } else {
            NSLog(@"parse has failed me!");
        }
             
    }];  
   

        
}

- (void)swipeRight:(UISwipeGestureRecognizer *)recognizer {
    [self performSegueWithIdentifier:@"MoodGraphViewController" sender:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
