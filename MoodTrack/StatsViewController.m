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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"furley_bg.png"]];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    PFUser *currentuser = [PFUser currentUser];
    
    // Finding average mood score
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"user" equalTo:currentuser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *moodvals = [[NSMutableArray alloc] init];
            for (PFObject *object in objects) {
                [moodvals addObject:[object objectForKey:@"mood_value"]];
            }
            NSNumber *sum = [moodvals valueForKeyPath:@"@sum.self"];
            float avg = [sum floatValue] / moodvals.count;
            
            self.AverageScore.text = [NSString stringWithFormat:@"%.02f", avg];            
        } else {
            NSLog(@"parse has failed me!");
        }
    }];
    
    //Finding average mood in past 3 days
    NSDate *threeDaysAgo  = [[NSDate date] dateByAddingTimeInterval: -259200.0];
    PFQuery *query3D = [PFQuery queryWithClassName:@"Mood"];
    query3D.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query3D whereKey:@"createdAt" greaterThan:threeDaysAgo];
    [query3D whereKey:@"user" equalTo:currentuser];
    [query3D findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *moodvals = [[NSMutableArray alloc] init];
            for (PFObject *object in objects) {
                [moodvals addObject:[object objectForKey:@"mood_value"]];
            }
            NSNumber *sum = [moodvals valueForKeyPath:@"@sum.self"];
            float avg = [sum floatValue] / moodvals.count;
            
            self.Average3Days.text = [NSString stringWithFormat:@"%.02f", avg];            
        } else {
            NSLog(@"parse has failed me!");
        }
    }];
    
    //Finding average mood score in past week
    NSDate *lastWeek  = [[NSDate date] dateByAddingTimeInterval: -604800.0];
    PFQuery *queryW = [PFQuery queryWithClassName:@"Mood"];
    queryW.cachePolicy = kPFCachePolicyNetworkElseCache;
    [queryW whereKey:@"createdAt" greaterThan:lastWeek];
    [queryW whereKey:@"user" equalTo:currentuser];
    [queryW findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *moodvals = [[NSMutableArray alloc] init];
            for (PFObject *object in objects) {
                [moodvals addObject:[object objectForKey:@"mood_value"]];
            }
            NSNumber *sum = [moodvals valueForKeyPath:@"@sum.self"];
            float avg = [sum floatValue] / moodvals.count;
            
            self.Average7Days.text = [NSString stringWithFormat:@"%.02f", avg];          
        } else {
            NSLog(@"parse has failed me!");
        }
    }];
    
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
