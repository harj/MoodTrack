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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"furley_bg.png"]];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSMutableArray *moodvals = [[NSMutableArray alloc] init];
            for (PFObject *object in objects) {
                [moodvals addObject:[object objectForKey:@"mood_value"]];
            }
            NSNumber *sum = [moodvals valueForKeyPath:@"@sum.self"];
            float avg = [sum floatValue] / moodvals.count;
                        
            self.AverageScore.text = [NSString stringWithFormat:@"%f", avg];            
        } else {
            NSLog(@"parse has failed me!");
        }
    }];

	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setAverageScore:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
